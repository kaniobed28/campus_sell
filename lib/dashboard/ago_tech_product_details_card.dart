import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/chat_list.dart';
import 'package:campus_sell/chat/individual_chat.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_copy_icon_button.dart';
import 'package:campus_sell/reusable_widgets/item_editable_widgets.dart';
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
    Key? key,
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
  }) : super(key: key);

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
                _buildActionButton(isOwnerController.isOwner, ownerId),
              ],
            ),
            const SizedBox(height: 8.0),

            // Description with Dropdown Effect
            _buildDescriptionSection(description),
            const SizedBox(height: 12.0),

            // Brand Name and Follow Section
            _buildBrandAndFollowSection(brandName, ownerId, followController),
            const SizedBox(height: 12.0),

            // Price Section
            _buildPriceSection(price),
            const SizedBox(height: 12.0),

            // Phone Number Section
            _buildPhoneSection(phone),
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

  Widget _buildActionButton(bool isOwner, String ownerId) {
    if (isOwner) {
      return IconButton(
        icon: const Icon(Icons.edit, color: Colors.grey),
        onPressed: () {
          // Edit logic
        },
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Get.to(ChatScreen(receiverId: ownerId));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text("Chat now", style: TextStyle(color: Colors.white)),
      );
    }
  }

  Widget _buildDescriptionSection(String description) {
    return ExpansionTile(
      title: const Text(
        "Description",
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandAndFollowSection(String brandName, String ownerId, FollowController followController) {
    return Row(
      children: [
        const Icon(Icons.business, color: Colors.grey),
        const SizedBox(width: 8.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.toNamed("/shop/shopitems/$ownerId");
            },
            child: Text(
              brandName,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Obx(() {
          return Row(
            children: [
              IconButton(
                icon: Icon(
                  followController.isFollowingShop.value ? Icons.favorite : Icons.favorite_border,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  followController.isFollowingShop.value
                      ? followController.unfollowShop(ownerId)
                      : followController.followShop(ownerId);
                },
              ),
              Text(
                '${followController.followerCount.value} followers',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildPriceSection(String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.attach_money, color: Colors.grey),
            const SizedBox(width: 5.0),
            Text(
              "Gh¢ $price",
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        CopyIconButton(value: price, label: 'Price'),
      ],
    );
  }

  Widget _buildPhoneSection(String phone) {
    return Row(
      children: [
        const Icon(Icons.phone, color: Colors.grey),
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            phone,
            style: const TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CopyIconButton(value: phone, label: 'Phone'),
      ],
    );
  }
}
