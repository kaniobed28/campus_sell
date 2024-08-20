import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Streamer extends GetxController {
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
  RxList<Map<String, dynamic>> servicesList = <Map<String, dynamic>>[].obs;

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
      kitchenList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Kitchen')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      fashionList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Fashion')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      jewelryList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Jewelry')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      foodList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Food')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      sportsList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Sports')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      beautyList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Beauty')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      electronicList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Electronic')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      othersList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Others')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      stationeryList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Stationery')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());

      healthcareList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Healthcare')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());
      servicesList.value = _sortByArrayLength(snapshot.docs
          .where((doc) => (doc.data() as Map<String, dynamic>)['itemType'] == 'Services')
          .map((doc) => {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              })
          .toList());
    });
  }
// this function sorts the list from highest to lowest based on the number of likes
  List<Map<String, dynamic>> _sortByArrayLength(List<Map<String, dynamic>> list) {
    list.sort((a, b) {
      int aLength = (a['likes'] as List<dynamic>).length;
      int bLength = (b['likes'] as List<dynamic>).length;
      return bLength.compareTo(aLength);
    });
    return list;
  }

  void unsubscribe() {
    subscription?.pause();
    // print("canceled");
  }

  @override
  void onClose() {
    unsubscribe();
    super.onClose();
  }
}
