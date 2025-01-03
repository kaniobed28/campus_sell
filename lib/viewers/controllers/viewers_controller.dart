import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

class ViewController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find<AuthController>();
  final FollowController followController = Get.find<FollowController>();

  // Function to mark an item as viewed by a user when clicked
  Future<void> markItemAsViewed(String itemId, String shopId) async {
    String userId = authController.uid.string;

    try {
      // Check if the item has already been marked as viewed
      // Locate the notification document for the specific item
      DocumentReference notificationDocRef = firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(userId)
          .collection('notifications')
          .doc(itemId);

      // Update the 'viewed' field to true
      await notificationDocRef.update({'viewed': true});

      // Optionally, add the user to the 'viewedBy' list in the 'items' collection
      
    } catch (e) {
      // Handle any errors that occur during the update
      print('Error marking item as viewed: $e');
    }
  }
// Function to mark an item as viewed in the 'viewedBy' list
  Future<void> markItemAsViewedByUser(String itemId) async {
    String userId = authController.uid.string;
    try {
      // Fetch the item document
      DocumentSnapshot itemSnapshot =
          await firebaseFirestore.collection('items').doc(itemId).get();

      // Get the 'viewedBy' list from the document
      List viewedByList =
          (itemSnapshot.data() as Map<String, dynamic>)['viewedBy'] ?? [];

      // If the user hasn't viewed the item, add them to the 'viewedBy' list
      if (userId != "") {
        
      if (!viewedByList.contains(userId)) {
        await firebaseFirestore.collection('items').doc(itemId).update({
          'viewedBy': FieldValue.arrayUnion([userId])
        });
      }
      }
    } catch (e) {
      print('Error updating viewedBy list: $e');
    }
  }
  // Function to retrieve all unviewed notifications for the user
  Future<List<Map<String, dynamic>>> getUnviewedNotifications() async {
    String userId = authController.uid.string;

    try {
      // Get the list of shops the user follows
      List<String> followedShops =
          await followController.getUserFollowedShops(userId);

      if (followedShops.isEmpty) {
        return []; // Return an empty list if the user follows no shops
      }

      // Fetch unviewed notifications where the shopId is in the followed shops list
      QuerySnapshot snapshot = await firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(userId)
          .collection('notifications')
          .where('viewed', isEqualTo: false)
          .where('shopId', whereIn: followedShops) // Filter by followed shops
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error retrieving unviewed notifications: $e');
      return [];
    }
  }

  // Function to notify all followers when a new item is posted
  Future<void> notifyFollowersOfNewItem(String shopId, String itemId) async {
    try {
      // Get the list of followers for the shop
      List<String> followers = await followController.getShopFollowers(shopId);

      if (followers.isEmpty) return; // No followers to notify

      // Create a batch write to efficiently notify all followers
      WriteBatch batch = firebaseFirestore.batch();

      for (String followerId in followers) {
        DocumentReference notificationRef = firebaseFirestore
            .collection('users_who_follow_shops')
            .doc(followerId)
            .collection('notifications')
            .doc(itemId); // Use itemId as the notification ID

        // Add the notification for each follower
        batch.set(notificationRef, {
          'itemId': itemId,
          'shopId': shopId,
          'viewed': false, // Mark the notification as unviewed
          'timestamp': FieldValue.serverTimestamp(),
        });
      }

      // Commit the batch write to Firestore
      await batch.commit();
    } catch (e) {
      print('Error notifying followers: $e');
    }
  }
}
