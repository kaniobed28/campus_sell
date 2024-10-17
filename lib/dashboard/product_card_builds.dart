import 'package:campus_sell/chat/individual_chat.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_copy_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailWidgets {
  // Method to build edit button or chat button depending on ownership
  static Widget buildEditProductName(bool isOwner, String ownerId) {
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

  // Method to build the description section
  static Widget buildDescriptionSection(String description) {
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

  // Method to build the brand and follow section
  static Widget buildBrandAndFollowSection(
      String brandName, String ownerId, FollowController followController) {
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
                  followController.isFollowingShop.value
                      ? Icons.favorite
                      : Icons.favorite_border,
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

  // Method to build the price section
  static Widget buildPriceSection(String price) {
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

  // Method to build the phone section
  static Widget buildPhoneSection(String phone) {
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
