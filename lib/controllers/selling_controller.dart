import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemForSaleController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   AuthController authController = Get.find<AuthController>();

  Future<void> addItem(String itemName, String itemType, String description,
      double price, List<dynamic> imagesUrls, String ownerId, availablePlaces) async {
    
    // Adding item to Firestore
    DocumentReference itemRef = await firebaseFirestore.collection("items").add({
      "itemName": itemName,
      "itemType": itemType,
      "description": description,
      "price": price,
      "imagesUrls": imagesUrls,
      "ownerId": ownerId,
      "availablePlaces": availablePlaces,
      "likes": [],
      "viewedBy": [], // Initialize the viewedBy field as an empty array
      "postedAt": FieldValue.serverTimestamp(),
    });

    // Notify followers of the new item
    await _notifyFollowers(ownerId, itemRef.id);
  }

  // Notify all followers of the shop about the new item
  Future<void> _notifyFollowers(String ownerId, String itemId) async {
    // Get followers of the shop
    List<String> followers = await FollowController().getShopFollowers(ownerId);
    
    for (String followerId in followers) {
      // Create a document in each follower's 'notifications' collection
      await firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(followerId)
          .collection('notifications')
          .doc(itemId)
          .set({
        "itemId": itemId,
        "shopId": ownerId,
        "viewed": false, // Set initial state of viewed to false
        "notifiedAt": FieldValue.serverTimestamp(),
      });
    }
  }

  // Function to mark an item as viewed by a user when clicked
  // Future<void> markItemAsViewed(String itemId, String shopId) async {
  //   String userId = authController.uid.string;

  //   try {
  //     // Mark the item as viewed for the user in their notifications
  //     await firebaseFirestore
  //         .collection('users_who_follow_shops')
  //         .doc(userId)
  //         .collection('notifications')
  //         .doc(itemId)
  //         .update({"viewed": true});

  //     // Optionally, I can also add the user to the 'viewedBy' list of the item
  //     await firebaseFirestore
  //         .collection('items')
  //         .doc(itemId)
  //         .update({
  //       "viewedBy": FieldValue.arrayUnion([userId])
  //     });
  //   } catch (e) {
  //     print('Error marking item as viewed: $e');
  //   }
  // }

}
