
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Streamer extends GetxController {

   @override
  void onClose() {
    unsubscribe();
    super.onClose();
  }
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? subscription;

  RxList<Map<String, dynamic>> kitchenList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> fashionList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> jewelryList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> foodList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> sportsList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> beautyList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> electronicList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> othersList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> stationeryList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> healthcareList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    streamData();
  }
  
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamData() {
    return subscription = firebaseFirestore
        .collection("items")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      kitchenList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Kitchen')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      fashionList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Fashion')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      jewelryList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Jewelry')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      foodList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Food')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      sportsList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Sports')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      beautyList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Beauty')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      electronicList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Electronic')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      othersList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Others')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      stationeryList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Stationery')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      healthcareList.value = snapshot.docs
          .where((doc) =>
              (doc.data() as Map<String, dynamic>)['itemType'] == 'Healthcare')
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  void unsubscribe() {
    subscription?.pause();
    print("canceled");
  }
}
