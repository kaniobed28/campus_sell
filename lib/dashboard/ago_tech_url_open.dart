import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/get_item_by_id_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_clicked_item_small_image.dart';
import 'package:campus_sell/dashboard/ago_tech_product_details_card.dart';
import 'package:campus_sell/likes/controller/likes.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoTechUrlOpen extends StatefulWidget {
  const AgoTechUrlOpen({super.key});

  @override
  State<AgoTechUrlOpen> createState() => _AgoTechClickedItemState();
}

class _AgoTechClickedItemState extends State<AgoTechUrlOpen> {
  LikeItem likeItemController = Get.put(LikeItem());
  final getItemByIdController = Get.put(GetItemByIdController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final additionalInfoController = Get.put(AdditionalInfoController());
    final authController = Get.put(AuthController());

    // final Map<String, dynamic> data = Get.arguments ?? {};
    final String? itemId = Get.parameters["id"];
    // final Map<String, dynamic> data =
    // List imageList = data["imagesUrls"];
    // final dynamic itemId = data["id"];
    likeItemController.containsUID(itemId, authController.uid.value);
    // final ownerInfo = additionalInfoController.getDocumentById(data["ownerId"]);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        height: 50,
      ),
      appBar: AppBar(
        actions: [
          Obx(() {
            return FittedBox(
              child: Column(
                children: [
                  // SizedBox(height: 1,),
                  IconButton(
                    icon: Icon(
                      likeItemController.liked.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: likeItemController.liked.value
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: () {
                      (!authController.isAuthenticated.value)
                          ? Get.snackbar("LogIn First",
                              "Tab on Home to move to the Login Screen")
                          : likeItemController.addAndRemoveLike(
                              itemId, authController.uid.value);
                      // loveController.toggleLove();

                      // likeItemController.containsUID(itemId, authController.uid.value);
                    },
                  ),
                  Text("${likeItemController.likesLength}")
                ],
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
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
                List imageList = itemData["imagesUrls"];
                return SizedBox(
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, //I have left space between the image and the details card
                    children: [
                      Center(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: (screenHeight < 450)
                                ? screenHeight * 0.4
                                : screenHeight * 0.65,
                            // aspectRatio: 2.0,
                            autoPlayInterval: const Duration(
                                seconds:
                                    8), // I am changing the images 8 sec if they are more than 1
                            enlargeCenterPage: true,
                            autoPlay: (imageList.length >= 2) ? true : false,
                          ),
                          items: imageList.map((i) {
                            return Material(
                              elevation: 20,
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                height: (screenHeight < 450)
                                    ? screenHeight * 0.4
                                    : screenHeight * 0.65,
                                width: screenWidth * .8,
                                // color: Colors.transparent,
                                child: AgoTechClickedItemSmallImage(
                                  imageUrl: i,
                                ), // I am taking the image url as arg from the carousel and use it to display it.
                              ),
                            );
                          }).toList(),
                        ),
                        // child: Material(
                        //   elevation: 20,
                        //   borderRadius: BorderRadius.circular(20),
                        //   child: SizedBox(
                        //     height: screenHeight * 0.4,
                        //     width: screenWidth * .8,
                        //     // color: Colors.transparent,
                        //     child: CarouselSlider(
                        //       items: data["imagesUrls"],
                        //       child: const AgoTechClickedItemSmallImage(imageUrl: ,)),
                        //   ),
                        // ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                        socialMedia: itemData["socialMedia"], ownerId: '', itemId: '',
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            }),
      ),
    );
  }
}
