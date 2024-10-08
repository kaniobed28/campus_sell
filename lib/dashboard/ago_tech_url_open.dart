import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/device_controller.dart';
import 'package:campus_sell/controllers/get_item_by_id_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_clicked_item_small_image.dart';
import 'package:campus_sell/dashboard/ago_tech_product_details_card.dart';
import 'package:campus_sell/likes/controller/likes.dart';
import 'package:campus_sell/reusable_widgets/custom_add_to_basket.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';  // Import the share_plus package

class AgoTechUrlOpen extends StatefulWidget {
  const AgoTechUrlOpen({super.key});

  @override
  State<AgoTechUrlOpen> createState() => _AgoTechClickedItemState();
}

class _AgoTechClickedItemState extends State<AgoTechUrlOpen> {
  LikeItem likeItemController = Get.find<LikeItem>();
  final getItemByIdController = Get.find<GetItemByIdController>();
  final DeviceController deviceController = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final additionalInfoController = Get.put(AdditionalInfoController());
    final authController = Get.put(AuthController());

    final String? itemId = Get.parameters["id"];
    likeItemController.containsUID(itemId, authController.uid.value);

    return FutureBuilder(
      future: getItemByIdController.getDocumentById(itemId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png"),);
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final itemData = snapshot.data;
          final ownerInfo = additionalInfoController.getDocumentById(itemData!["ownerId"]);
          List imageList = itemData["imagesUrls"];

          // Construct the share content here
          final String description = itemData["description"];
          final String url = "https://campussell.github.io/#/shopitems/itemcode/$itemId";
          final String contentToShare = "$description\n\n$url";

          return SafeArea(
            child: Scaffold(
              bottomNavigationBar:Visibility(
                    visible: !deviceController.isWeb.value,
                    child: CustomBottomNavBar(height: 50)),
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                actions: [
                  Obx(() {
                    return FittedBox(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              likeItemController.liked.value
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: likeItemController.liked.value ? Colors.red : Theme.of(context).colorScheme.onSurface,
                            ),
                            onPressed: () {
                              if (!authController.isAuthenticated.value) {
                                Get.snackbar("LogIn First", "Tap on Home to move to the Login Screen");
                              } else {
                                likeItemController.addAndRemoveLike(itemId, authController.uid.value);
                              }
                            },
                          ),
                          Text("${likeItemController.likesLength}")
                        ],
                      ),
                    );
                  }),
                  // Share Icon Button
                  IconButton(
                    icon:  Icon(Icons.share, color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () {
                      Share.share(contentToShare);
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: (screenHeight < 450) ? screenHeight * 0.4 : screenHeight * 0.65,
                              autoPlayInterval: const Duration(seconds: 8),
                              enlargeCenterPage: true,
                              autoPlay: (imageList.length >= 2) ? true : false,
                            ),
                            items: imageList.map((i) {
                              return Material(
                                elevation: 20,
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  height: (screenHeight < 450) ? screenHeight * 0.4 : screenHeight * 0.65,
                                  width: screenWidth * .8,
                                  child: AgoTechClickedItemSmallImage(imageUrl: i),
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: AddToBasketButton(
                              itemId: itemId,
                              isAuthenticated: authController.isAuthenticated,
                              userId: authController.uid.value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AgoTechProductDetailsCard(
                        title: itemData["itemName"],
                        description: itemData["description"],
                        price: itemData['price'].toString(),
                        brandName: itemData["brand"],
                        phone: itemData["phone"],
                        city: itemData["city"],
                        hostel: itemData["hostel"],
                        university: itemData["university"],
                        itemType: itemData["itemType"],
                        socialMedia: itemData["socialMedia"],
                        ownerId: itemData["ownerId"],
                        itemId: itemId,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
