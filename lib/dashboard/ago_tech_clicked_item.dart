import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_clicked_item_small_image.dart';
import 'package:campus_sell/dashboard/ago_tech_product_details_card.dart';
import 'package:campus_sell/likes/controller/likes.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoTechClickedItem extends StatefulWidget {
  const AgoTechClickedItem({super.key});

  @override
  State<AgoTechClickedItem> createState() => _AgoTechClickedItemState();
}

class _AgoTechClickedItemState extends State<AgoTechClickedItem> {
  LikeItem likeItemController = Get.put(LikeItem());
    final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // final additionalInfoController = Get.put(AdditionalInfoController());

    final Map<String, dynamic> data = Get.arguments ?? {};
    List imageList = data["imagesUrls"];
    final dynamic itemId = data["id"];
    likeItemController.containsUID(itemId, authController.uid.value);
    // final ownerInfo = additionalInfoController.getDocumentById(data["ownerId"]);

    return Scaffold(
      // backgroundColor: const Color(0xFFF2F2F2 ),
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
                        // loveController.toggleLove();
                        likeItemController.addAndRemoveLike(itemId, authController.uid.value);
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
        
        child: SizedBox(
          width: screenWidth,
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, //I have left space between the image and the details card
            children: [
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: (screenHeight<450)? screenHeight * 0.4:screenHeight * 0.65,
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
                        height: (screenHeight<450)? screenHeight * 0.4:screenHeight * 0.65,
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
                height:10,
              ),
 
                 AgoTechProductDetailsCard(title: data["itemName"], description: data["description"], price: data['price'].toString(), brandName: data["brand"], phone:data["phone"], hostel: data["hostel"], city: data["city"], university: data["university"], itemType: data["itemType"], socialMedia: data["socialMedia"], ownerId: data["ownerId"],itemId: itemId,),
              
            ],
          ),
        ),
      ),
    );
  }
}
