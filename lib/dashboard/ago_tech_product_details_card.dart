import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/chat_list.dart';
import 'package:campus_sell/chat/individual_chat.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_copy_icon_button.dart';
import 'package:campus_sell/reusable_widgets/item_editable_widgets.dart';
import 'package:campus_sell/reusable_widgets/more_details_page.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart'; // Import FollowController
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
    final FollowController followController = Get.put(FollowController()); // Initialize FollowController
    final IsOwnerController isOwnerController = Get.find<IsOwnerController>();
    final AuthController authController = Get.find<AuthController>();

    // Fetch the number of followers for the shop on init
    followController.getShopFollowers(ownerId);

    isOwnerController.isShopItemOwner(authController.uid.value, ownerId);
        followController.checkIfFollowing(ownerId);


    return Card(
      color: const Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title and Edit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isOwnerController.isOwner)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit logic
                    },
                  )
                else
                  TextButton(
                    onPressed: () {
                      Get.to(ChatScreen(receiverId: ownerId));
                    },
                    child: const Text(
                      "Chat now",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5.0),

            // Description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Brand Name, Follow Button, and Follower Count
            Row(
              children: <Widget>[
                Icon(Icons.add_business_sharp, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed("/shop/shopitems/$ownerId");
                          },
                          child: Text(
                            brandName,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Obx(() {
                        // Follow button with follower count
                        return Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                followController.isFollowingShop.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.redAccent,
                                // here is where I implemented the logic for the Icon.
                                // I will change the Icon from favoriate to another things else.
                              ),
                              onPressed: () {
                                authController.checkAuthentication(cancelRoute: "/shopitems/itemcode/$itemId");
                                if (followController.isFollowingShop.value) {
                                  followController.unfollowShop(ownerId);
                                } else {
                                  followController.followShop(ownerId);
                                }
                              },
                            ),
                            Text(
                              // I did show followers count here
                              '${followController.followerCount.value} followers',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Price and Copy Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Icon(Icons.sell, color: Colors.grey[600]),
                    const SizedBox(width: 5.0),
                    Text(
                      " \$$price",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                CopyIconButton(value: price, label: 'Price'),
              ],
            ),
            const SizedBox(height: 10.0),

            // Phone Number and Copy Button
            Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          phone,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CopyIconButton(value: phone, label: 'Phone'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // More Details Button
            _buildMoreDetailsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreDetailsButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
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
        child: const Text(
          'More Details',
          style: TextStyle(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
