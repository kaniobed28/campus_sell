import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/forms_repo/search_screen.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/main_board/buy_promotion.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:campus_sell/main_board/delete_page.dart';
import 'package:campus_sell/signup_in/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardM extends StatelessWidget {
  DashBoardM({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    const FontWeight fontWeight = FontWeight.bold;
    const double itemTypeFontSize = 25.0;
    TextStyle fontStyeleForItemTypes = GoogleFonts.average(
        fontWeight: fontWeight,
        fontSize: itemTypeFontSize,
        color: Colors.white);
    double widthtOfScreen =
        MediaQuery.of(context).size.width; // returns width of the screen

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 245, 245, 245), // should be changed to theme.
        endDrawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Container(
                    width: 120.0, // Adjust width as needed
                    height: 120.0, // Adjust height as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.amber,
                        width: 2.0, // Adjust border width as needed
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/img/campus-sell-favicon-color.png",
                        width: 100.0, // Adjust width as needed
                        height: 100.0, // Adjust height as needed
                        fit: BoxFit
                            .cover, // Ensures the image fits within the given dimensions
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Additional Info',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SellInfoScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(
                  'Search Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SearchScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.sell),
                title: Text(
                  'Sell Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => SellPage()),
              ),
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: Text(
                  'Remove Item',
                  style: GoogleFonts.average(),
                ),
                onTap: () => Get.to(() => const DeleteScreen()),
              ),
              ListTile(
                leading: const Icon(Icons.tv),
                title: Text(
                  'Promotion',
                  style: GoogleFonts.average(),
                ),
                onTap: () {
                  //
                  Get.to(() => BuyPromotion());
                },
              ),
              ListTile(
                leading: const Icon(Icons.outbond),
                title: Text(
                  'SignOut',
                  style: GoogleFonts.average(),
                ),
                onTap: () {
                  // AuthController authController = Get.find<AuthController>();
                  // AuthController authController = Get.put(AuthController());
                  authController.signOut();
                  // authController.dispose();
                  Get.offAll(() => SignIn());
                },
              ),
            ],
          ),
        ),
        body: SizedBox(
          width: widthtOfScreen,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                // foregroundColor: Colors.amber,
                expandedHeight: 200,
                floating: true,
                // pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(
                      left: 2, top: 30, right: 2, bottom: 10),
                  centerTitle: true,
                  title: TitleSingleScrollView(),
                  expandedTitleScale: 2,
                  background: Container(
                    decoration: const BoxDecoration(
                        // color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    margin: const EdgeInsets.all(0),
                    child: const Image(
                        image: AssetImage(
                            "assets/img/campus-sell-logo-transparent.png")),
                  ),
                ),
              ),
              // FutureBuilderForRowItemsOnDashboard( widtht_of_screen,),

              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Fashion",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Fashion"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Food",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child:
                    streamBuilderForRowItemsOnDashboard(widthtOfScreen, "Food"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Electronic",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Electronic"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Beauty Product",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Beauty"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Sports Equipment",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Sports"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Stationery",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Stationery"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Healthcare Product",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Healthcare"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Kitchen Appliances",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Kitchen"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Jewelry",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Jewelry"),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 46, 48, 48), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6), // Adjust padding as needed
                      child: Text(
                        "Other",
                        style: fontStyeleForItemTypes,
                      ),
                    ),
                    Container(
                      height: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: streamBuilderForRowItemsOnDashboard(
                    widthtOfScreen, "Others"),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>
      streamBuilderForRowItemsOnDashboard(double screenWidth, String itemType) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("items").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          List<DocumentSnapshot<Map<String, dynamic>>> items =
              snapshot.data!.docs;
          List<DocumentSnapshot<Map<String, dynamic>>> filteredItems = items
              .where((item) => item.data()!['itemType'] == itemType)
              .toList();
          return SizedBox(
            height: 200,
            width:
                screenWidth, //size of the horizontal display for groups of items
            child: GridView.builder(
              // used gridview because listview was giving me problem on horizontal axis
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1, // Set the spacing between items
              ),
              itemCount: filteredItems
                  .length, //remember to change always to filtered length
              itemBuilder: (context, index) {
                return GestureDetector(
                  // padding and container is wrapped on the display card just for shadow effect and allow padding.
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                    2, 3), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: displayCard(filteredItems, index))),
                  onTap: () => Get.to(const ClickedItem(),
                      arguments: filteredItems[index].data()),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('Error Loading Data'));
        }
      },
    );
  }

  Stack displayCard(
      List<DocumentSnapshot<Map<String, dynamic>>> filteredItems, int index) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          // color: Colors.amber,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)), // Adjust the radius as needed
            child: CachedNetworkImage(
              height: 170,
              imageUrl: filteredItems[index].data()!['imagesUrls'][0],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight:
                      Radius.circular(10)), // Adjust the radius as needed

              border:
                  Border.all(color: const Color.fromARGB(255, 222, 222, 222)),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      filteredItems[index]
                          .data()!['itemName']
                          .toString()
                          .trim(),
                      style: GoogleFonts.aclonica(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "GHS ${filteredItems[index].data()!['price'].toString().trim()}",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(DashBoardM());
// }

Visibility TitleSingleScrollView() {
  const bool statusIsVisible = false;

  return Visibility(
    visible: statusIsVisible,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // width: ,
        child: Row(
          children: [
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:
                    Border.all(color: const Color.fromARGB(255, 255, 255, 245)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.amberAccent,

                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
              ),
              child: const Image(
                  image: AssetImage(
                      "assets/img/campus-sell-logo-transparent.png")),
            ),
            // CircleAvatar(
            //   radius: 20,
            //   backgroundColor: Colors.black,
            //   child: CircleAvatar(
            //     radius: 17,
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
