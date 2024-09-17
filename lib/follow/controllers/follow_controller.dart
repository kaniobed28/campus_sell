import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

class FollowController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();

  var isFollowingShop = false.obs; // Reactive variable to track follow status
  var followerCount = 0.obs; // Track number of followers

  // Function to follow a shop
  Future<void> followShop(String shopId) async {
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      // Add the user as a follower of the shop
      await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .set({});

      // Add the shop to the user's followedShops
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedShops')
          .doc(shopId)
          .set({});

      isFollowingShop.value = true;
      _updateFollowerCount(shopId);
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to unfollow a shop
  Future<void> unfollowShop(String shopId) async {
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      // Remove the user as a follower of the shop
      await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .delete();

      // Remove the shop from the user's followedShops
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedShops')
          .doc(shopId)
          .delete();

      isFollowingShop.value = false;
      _updateFollowerCount(shopId);
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to check if a user is following a shop
  Future<void> checkIfFollowing(String shopId) async {
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      DocumentSnapshot doc = await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .get();

      // Update the follow status based on whether the document exists
      isFollowingShop.value = doc.exists;
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to update the follower count
  Future<void> _updateFollowerCount(String shopId) async {
    try {
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      followerCount.value = followersSnapshot.docs.length; // Update follower count
    } catch (e) {
      _handleError(e);
    }
  }

  // Get the list of shops the user follows
  Future<List<String>> getUserFollowedShops(String userId) async {
    try {
      QuerySnapshot followedShopsSnapshot = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedShops')
          .get();

      return followedShopsSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  // Get the list of followers for a shop
  Future<List<String>> getShopFollowers(String shopId) async {
    try {
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      followerCount.value = followersSnapshot.docs.length; // Set initial count
      return followersSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      _handleError(e);
      return [];
    }
  }

  // Helper function to check if the user is authenticated
  bool _isUserAuthenticated() {
    return authController.isAuthenticated.value;
  }

  // Helper function to handle errors
  void _handleError(dynamic error) {
    print('An error occurred: $error');
  }
}
