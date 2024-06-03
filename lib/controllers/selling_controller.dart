<<<<<<< HEAD
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
=======
>>>>>>> c8065632fe2d20d82a1f3d85121330c51077fbd0
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemForSaleController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addItem(String itemName, String itemType, String description,
      double price, List<String> imagesUrls, String ownerId) async {
    await firebaseFirestore.collection("items").add({
      "itemName": itemName,
      "itemType": itemType,
      "description": description,
      "price": price,
      "imagesUrls": imagesUrls,
      "ownerId": ownerId,
      "brand": "",
      "city": "",
      "hostel": "",
      "phone": "",
      "socialMedia": "",
      "university": "",
    });
  }
  // update with this anytime an item is added and anytime additional info is updated
}
