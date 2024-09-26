import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

// This controller manages following/unfollowing of shops and tracks followers for each shop.
// `users_who_follow_shops` stores user IDs and the shops they follow as "followedShops" (only the shop IDs).
// `shops_whom_users_follow` stores shop IDs and the users that follow each shop (only the user IDs).

class FollowController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find<AuthController>();

  // Reactive variables to track if a user is following a shop and the follower count
  var isFollowingShop = false.obs; 
  var followerCount = 0.obs; 

  // Function to follow a shop by adding the shop to both user and shop collections.
  Future<void> followShop(String shopId) async {
    // Ensure the user is authenticated before proceeding
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      // Add user ID to the shop's followers collection
      await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .set({});

      // Add shop ID to the user's followed shops collection
      await firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(userId)
          .collection('followedShops')
          .doc(shopId)
          .set({});

      // Update the local state to indicate the shop is being followed
      isFollowingShop.value = true;
      
      // Update the shop's follower count
      _updateFollowerCount(shopId);
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to unfollow a shop by removing the shop from both user and shop collections.
  Future<void> unfollowShop(String shopId) async {
    // Ensure the user is authenticated before proceeding
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      // Remove user ID from the shop's followers collection
      await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .delete();

      // Remove shop ID from the user's followed shops collection
      await firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(userId)
          .collection('followedShops')
          .doc(shopId)
          .delete();

      // Update the local state to indicate the shop is no longer being followed
      isFollowingShop.value = false;

      // Update the shop's follower count
      _updateFollowerCount(shopId);
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to check if the current user is following a particular shop.
  Future<void> checkIfFollowing(String shopId) async {
    // Ensure the user is authenticated before proceeding
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      // Check if the user ID exists in the shop's followers collection
      DocumentSnapshot doc = await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .get();

      // Update the local state based on whether the user is following the shop
      isFollowingShop.value = doc.exists;
    } catch (e) {
      _handleError(e);
    }
  }

  // Private function to update the follower count of a shop.
  Future<void> _updateFollowerCount(String shopId) async {
    try {
      // Fetch the current list of followers for the shop
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      // Update the follower count with the number of documents (followers)
      followerCount.value = followersSnapshot.docs.length;
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to get a list of shop IDs that the user follows.
  Future<List<String>> getUserFollowedShops(String userId) async {
    try {
      // Fetch the user's followed shops collection
      QuerySnapshot followedShopsSnapshot = await firebaseFirestore
          .collection('users_who_follow_shops')
          .doc(userId)
          .collection('followedShops')
          .get();

      // Map the results to a list of shop IDs
      return followedShopsSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  // Function to get a list of user IDs following a particular shop.
  Future<List<String>> getShopFollowers(String shopId) async {
    try {
      // Fetch the list of followers for the shop
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      // Update the follower count with the number of followers
      followerCount.value = followersSnapshot.docs.length;

      // Map the results to a list of user IDs
      return followersSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  // Helper function to check if the user is authenticated.
  bool _isUserAuthenticated() {
    // Returns true if the user is authenticated
    return authController.isAuthenticated.value;
  }

  // Helper function to handle any errors that occur.
  void _handleError(dynamic error) {
    // Print the error to the console
    print('An error occurred: $error');
  }
}
