import 'package:get/get.dart';

class IsOwnerController extends GetxController {
  // Variable to track ownership status
  bool isOwner = false;

  // Method to check if the ownerUid is the same as userUid
  void isShopItemOwner(String ownerUid, String userUid) {
    print(ownerUid);
    print(userUid);
    if (ownerUid == userUid) {
      isOwner = true;
    } else {
      isOwner = false;
    }
  }
}
