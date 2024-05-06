import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemForSaleController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addItem(String itemName, String itemType, String description,
      double price, List<String> imagesUrls,String ownerId ) async {
    await firebaseFirestore.collection("items").add({
      "itemName": itemName,
      "itemType": itemType,
      "description": description,
      "price": price,
      "imagesUrls": imagesUrls,
      "ownerId":ownerId
    });
  }
}
