import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/dashboard/product_card_builds.dart';
import 'package:campus_sell/reusable_widgets/more_details_page.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoTechProductDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String brandName;
  final String phone;
  final String city;
  final String hostel;
  final String university;
  final String itemType;
  final String socialMedia;
  final String ownerId;
  final String itemId;


   const AgoTechProductDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.brandName,
    required this.phone,
    required this.city,
    required this.hostel,
    required this.university,
    required this.itemType,
    required this.socialMedia,
    required this.ownerId,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context) {
    final FollowController followController = Get.put(FollowController());
    final IsOwnerController isOwnerController = Get.find<IsOwnerController>();
    final AuthController authController = Get.find<AuthController>();

    // Initialize data
    followController.getShopFollowers(ownerId);
    isOwnerController.isShopItemOwner(authController.uid.value, ownerId);
    followController.checkIfFollowing(ownerId);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Pass `isOwner` to the widget to show edit button or chat button
                ProductDetailWidgets.buildEditProductName(isOwnerController.isOwner, ownerId),
              ],
            ),
            const SizedBox(height: 8.0),

            // Description with Dropdown Effect
            ProductDetailWidgets.buildDescriptionSection(description, ),
            const SizedBox(height: 12.0),

            // Brand Name and Follow Section
            ProductDetailWidgets.buildBrandAndFollowSection(
                brandName, ownerId, followController, ),
            const SizedBox(height: 12.0),

            // Price Section
            ProductDetailWidgets.buildPriceSection(price,),
            const SizedBox(height: 12.0),

            // Phone Number Section
            ProductDetailWidgets.buildPhoneSection(phone, ),
            const SizedBox(height: 12.0),

            // More Details Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => MoreDetailsPage(
                    title: title,
                    brandName: brandName,
                    price: price,
                    phone: phone,
                    city: city,
                    hostel: hostel,
                    university: university,
                    itemType: itemType,
                    socialMedia: socialMedia,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "More Details",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
