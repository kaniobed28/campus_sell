import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/get_item_by_id_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoveController extends GetxController {
  var isLoved = false.obs;

  void toggleLove() {
    isLoved.value = !isLoved.value;
  }
}

class ClickedItemC extends StatelessWidget {
  const ClickedItemC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? itemId = Get.parameters["id"];

    final additionalInfoController = Get.put(AdditionalInfoController());
    final loveController = Get.put(LoveController());
    final getItemByIdController = Get.put(GetItemByIdController());

    final Map<String, dynamic> data = Get.arguments ?? {};

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double calculateScreenFraction(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth >= 600) return 0.7;
      if (screenWidth >= 400) return 0.6;
      return 0.5;
    }

    final screenFraction = calculateScreenFraction(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Details',
            style: GoogleFonts.average(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            Obx(() {
              return IconButton(
                icon: Icon(
                  loveController.isLoved.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      loveController.isLoved.value ? Colors.red : Colors.black,
                ),
                onPressed: loveController.toggleLove,
              );
            }),
          ],
        ),
        body: FutureBuilder(
          future: getItemByIdController.getDocumentById(itemId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final itemData = snapshot.data;
              final ownerInfo = additionalInfoController
                  .getDocumentById(itemData!["ownerId"]);
              return Column(
                children: [
                  Container(
                    height: screenHeight * screenFraction,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                          ),
                          child: PageView.builder(
                            itemCount: itemData['imagesUrls'].length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl:
                                    itemData['imagesUrls'][index].toString(),
                                fit: BoxFit.fill,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error, size: 50),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'GH¢ ${itemData["price"]?.toString() ?? "Not Set"}',
                              style: GoogleFonts.aclonica(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.blueGrey[800],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildListTile('Item Name', data["itemName"],
                                  Icon(Icons.delivery_dining_sharp)),
                              _buildFutureListTile(
                                  'Owner\'s Brand',
                                  ownerInfo,
                                  'brand',
                                  const Icon(Icons.branding_watermark)),
                              _buildListTile(
                                  'Price',
                                  'GH¢ ${data["price"]?.toString() ?? "Not Set"}',
                                  Icon(Icons.sell)),
                              _buildFutureListTile('Phone', ownerInfo, 'phone',
                                  const Icon(Icons.price_change_rounded)),
                              _buildFutureListTile(
                                  'Social Media',
                                  ownerInfo,
                                  'socialMedia',
                                  const Icon(Icons.message_rounded)),
                              _buildFutureListTile('City', ownerInfo, 'city',
                                  const Icon(Icons.my_location)),
                              _buildFutureListTile('University', ownerInfo,
                                  'university', const Icon(Icons.school)),
                              _buildFutureListTile(
                                  'Address/Hostel',
                                  ownerInfo,
                                  'hostel',
                                  const Icon(Icons.location_on_outlined)),
                              _buildListTile('Description', data["description"],
                                  Icon(Icons.note_alt_outlined)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildListTile(String title, dynamic value, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 10,
        color: Colors.blueGrey[300],
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), bottomLeft: Radius.circular(10)),
        child: ListTile(
          leading: icon,
          title: Text(
            '$title: ${value?.toString() ?? "Not Set"}',
            style: GoogleFonts.aclonica(
                fontSize: 16, color: const Color(0xFFFFFFFF)),
          ),
          trailing: GestureDetector(
            child: const Text("copy"),
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: value?.toString() ?? "Not Set"));
              Get.snackbar(
                  "Copied to Cliipboard", value?.toString() ?? "Not Set",
                  duration: const Duration(seconds: 1, milliseconds: 500));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFutureListTile(String title,
      Future<Map<String, dynamic>?> future, String key, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListTile(
              title: Text('Loading $title information...',
                  style: GoogleFonts.aclonica(fontSize: 16)),
            );
          } else if (snapshot.hasError) {
            return ListTile(
              title: Text('Error retrieving $title information',
                  style: GoogleFonts.aclonica(fontSize: 16)),
            );
          } else if (snapshot.hasData) {
            return Material(
              elevation: 10,
              color: Colors.blueGrey[300],
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(10)),
              child: ListTile(
                leading: icon,
                title: Text(
                  '$title: ${snapshot.data?[key]?.toString() ?? "Not Set"}',
                  style: GoogleFonts.aclonica(
                      fontSize: 16, color: const Color(0xFFFFFFFF)),
                ),
                trailing: GestureDetector(
                  child: const Text("copy"),
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: snapshot.data?[key]?.toString() ?? "Not Set"));
                    Get.snackbar("Copied to Cliipboard",
                        snapshot.data?[key]?.toString() ?? "Not Set",
                        duration:
                            const Duration(seconds: 1, milliseconds: 500));
                  },
                ),
              ),
            );
          } else {
            return ListTile(
              title: Text('No $title information available',
                  style: GoogleFonts.aclonica(fontSize: 16)),
            );
          }
        },
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    home: const ClickedItemC(),
    initialRoute: '/',
    getPages: [
      GetPage(name: '/listscreen', page: () => const ListScreen()),
      GetPage(name: '/:id', page: () => const ClickedItemC()),
    ],
    navigatorKey: Get.key,
  ));
}
