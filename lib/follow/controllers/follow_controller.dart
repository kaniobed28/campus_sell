import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

class FollowController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final AuthController authController = Get.find<AuthController>();

  var isFollowingShop = false.obs;
  var followerCount = 0.obs;

  // Function to follow a shop
  Future<void> followShop(String shopId) async {
    if (!_isUserAuthenticated()) return;

    String userId = authController.uid.string;
    try {
      await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .set({});

      await firebaseFirestore
          .collection('users_who_follow_shops')
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
      await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .delete();

      await firebaseFirestore
          .collection('users_who_follow_shops')
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
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .doc(userId)
          .get();

      isFollowingShop.value = doc.exists;
    } catch (e) {
      _handleError(e);
    }
  }

  // Function to update the follower count
  Future<void> _updateFollowerCount(String shopId) async {
    try {
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      followerCount.value = followersSnapshot.docs.length;
    } catch (e) {
      _handleError(e);
    }
  }

  // Get the list of shops the user follows
  Future<List<String>> getUserFollowedShops(String userId) async {
    try {
      QuerySnapshot followedShopsSnapshot = await firebaseFirestore
          .collection('users_who_follow_shops')
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
          .collection('shops_whom_users_follow')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      followerCount.value = followersSnapshot.docs.length;
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
