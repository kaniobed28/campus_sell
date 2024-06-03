import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(AllTypeHome());
}

class AllTypeHome extends StatelessWidget {
  const AllTypeHome({super.key});

  @override
  Widget build(BuildContext context) {
        const FontWeight fontWeight = FontWeight.bold;
    const double itemTypeFontSize = 25.0;
    TextStyle fontStyeleForItemTypes = GoogleFonts.average(
        fontWeight: fontWeight,
        fontSize: itemTypeFontSize,
        color: Colors.white);
    double widthtOfScreen =
        MediaQuery.of(context).size.width; 
    return allTypeHome(fontStyeleForItemTypes, widthtOfScreen);
    
  }


  Column allTypeHome(TextStyle fontStyeleForItemTypes, double widthtOfScreen) {
    return Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Fashion"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(widthtOfScreen, "Food"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Electronic"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Beauty"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Sports"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Stationery"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Healthcare"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Kitchen"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Jewelry"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 46, 48, 48), // Background color
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
                  streamBuilderForRowItemsOnDashboard(
                      widthtOfScreen, "Others"),
                  Container(
                    height: 5,
                    color: Colors.white,
                  ),
                ],
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



