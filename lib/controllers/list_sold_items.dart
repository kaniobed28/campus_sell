import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSearchItems extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> soldItems = [];
  List<String> ownerIds = [];

  Future<void> listFromAddInfo(
    String university,
    String city,
    String? brand,
    String? hostel,
  ) async {
    final CollectionReference collectionRef =
        firebaseFirestore.collection('add_info');
    Query<Object?> query = collectionRef;
    if (university != "Select University" && university != "") {
      query = collectionRef.where("university", isEqualTo: university);

    }
    if (city != "Select City" && city != "") {
      query = collectionRef.where("city", isEqualTo: city);
    }
    if (brand != "" && brand != null) {
      query = collectionRef.where("brand", isEqualTo: brand);
    }
    if (hostel != "" && hostel != null) {
      query = collectionRef.where("hostel", isEqualTo: hostel);
     
    }
    QuerySnapshot querySnapshot = await query.get();
    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      String ownerId = documentSnapshot.id;
      ownerIds.add(ownerId);
      // print(ownerIds);
      
    }

  }

  Future<void> listSearchItems(
    
    
    String itemType,
    String university,
    String city,
    String? brand,
    String? hostel,
  ) async {
    await listFromAddInfo(university, city, brand, hostel);
    final CollectionReference collectionRef =
        firebaseFirestore.collection('items');
    Query<Object?> query = collectionRef;
    // QuerySnapshot querySnapshot = await collectionRef
    //     .where('ownerId', isEqualTo: itemId).where("itemType" ,isEqualTo: "electronic").where("price" ,isEqualTo: 100.0)
    //     .get();
    if (ownerIds.isNotEmpty) {
      print(ownerIds.isNotEmpty);
      query = collectionRef.where('ownerId', whereIn: ownerIds);
      
  //   QuerySnapshot querySnapshot = await query.get();
  // print(querySnapshot.size);
  //   for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //     print(documentSnapshot.data() as Map<String, dynamic>);
  //   }



      // print(collectionRef.where('ownerId', arrayContainsAny: ownerIds).get());
    }
    if (itemType != "Select Item Type" && itemType != "") {
      query = collectionRef.where("itemType", isEqualTo: itemType);

      print(itemType);
    }
    QuerySnapshot querySnapshot = await query.get();

     for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
       soldItems.add(documentSnapshot.data() as Map<String, dynamic>);
     }
   print(soldItems.length);
   soldItems.clear();
  }
}
