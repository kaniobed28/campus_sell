import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';

class FollowController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final authController = Get.find<AuthController>();

  var isFollowingShop = false.obs; // Reactive variable to track follow status
  var followedShops = <String>[].obs; // List of shops the user is following

  // Function to follow a shop
  Future<void> followShop(String shopId) async {
    if (authController.isAuthenticated.value) {
      String userId = authController.uid.string;
      try {
        await firebaseFirestore
            .collection('followers')
            .doc(shopId)
            .collection('userFollowers')
            .doc(userId)
            .set({});

        // Update the local state to reflect that the user is now following this shop
        isFollowingShop.value = true;
        followedShops.add(shopId);
      } catch (e) {
        throw e;
      }
    }
  }

  // Function to unfollow a shop
  Future<void> unfollowShop(String shopId) async {
    if (authController.isAuthenticated.value) {
      String userId = authController.uid.string;
      try {
        await firebaseFirestore
            .collection('followers')
            .doc(shopId)
            .collection('userFollowers')
            .doc(userId)
            .delete();

        // Update the local state to reflect that the user has unfollowed this shop
        isFollowingShop.value = false;
        followedShops.remove(shopId);
      } catch (e) {
        throw e;
      }
    }
  }

  // Check if the user is following a shop
  Future<void> checkIfFollowing(String shopId) async {
    if (authController.isAuthenticated.value) {
      String userId = authController.uid.string;
      try {
        DocumentSnapshot doc = await firebaseFirestore
            .collection('followers')
            .doc(shopId)
            .collection('userFollowers')
            .doc(userId)
            .get();

        isFollowingShop.value = doc.exists; // Update reactive variable
      } catch (e) {
        throw e;
      }
    }
  }

  // Function to notify followers when a new item is posted by the shop
  Future<void> notifyFollowers(String shopId, String itemId) async {
    try {
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      for (var follower in followersSnapshot.docs) {
        String followerId = follower.id;

        // Example: Add a new feed entry for the user
        await firebaseFirestore
            .collection('userFeeds')
            .doc(followerId)
            .collection('items')
            .doc(itemId)
            .set({
          'itemId': itemId,
          'shopId': shopId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw e;
    }
  }

  // Get list of shops that the current user is following
  Future<void> getFollowedShops() async {
    if (authController.isAuthenticated.value) {
      String userId = authController.uid.string;
      try {
        QuerySnapshot followedShopsSnapshot = await firebaseFirestore
            .collectionGroup('userFollowers')
            .where(FieldPath.documentId, isEqualTo: userId)
            .get();

        followedShops.clear(); // Clear the list before updating
        for (var doc in followedShopsSnapshot.docs) {
          followedShops.add(doc.reference.parent.parent!.id); // Get shopId
        }
      } catch (e) {
        throw e;
      }
    }
  }

  // Get the total number of followers a shop has
  Future<int> getShopFollowersCount(String shopId) async {
    try {
      QuerySnapshot followersSnapshot = await firebaseFirestore
          .collection('followers')
          .doc(shopId)
          .collection('userFollowers')
          .get();

      return followersSnapshot.size;
    } catch (e) {
      throw e;
    }
  }

  // Refresh the follow status (useful when user opens the shop details page)
  Future<void> refreshFollowStatus(String shopId) async {
    await checkIfFollowing(shopId);
    await getFollowedShops();
  }
}
