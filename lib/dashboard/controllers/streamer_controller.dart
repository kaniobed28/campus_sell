import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';



//This is where I fetch the items from firebase and I feed it to the app as a stream.
//the items are fetch based on the category from firebase and added to a rxlist of map.
//Each list contains maps of items. 
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
    streamData();  // You can pass these as needed
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> streamData({
  String? country,
  String? city,
  String? university,
}) {
  Query<Map<String, dynamic>> query = firebaseFirestore.collection("items");

  // I will use this feature in the future where I will allow the app to multiple countries.
  // Apply country or city or university is not empty or null, filter if provided.
  if ((country != null && country.isNotEmpty)||(city != null && city.isNotEmpty)||(university != null && university.isNotEmpty)) {
    query = query.where('availablePlaces', arrayContainsAny: ["","KNUST",]);
  }


// Before the items are uploaded to firebase they are captilized first so when fetching them we must make sure the type contains capital letter first


  // Listen to the filtered query
  return subscription = query.snapshots().listen((QuerySnapshot snapshot) {
    List<Map<String, dynamic>> filteredDocs = snapshot.docs.map((doc) => {
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        }).toList();

    // Now you can categorize and sort these documents into your lists as before
    kitchenList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Kitchen')
        .toList());

    fashionList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Fashion')
        .toList());

    jewelryList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Jewelry')
        .toList());

    foodList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Food')
        .toList());

    sportsList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Sports')
        .toList());

    beautyList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Beauty')
        .toList());

    electronicList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Electronic')
        .toList());

    othersList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Others')
        .toList());

    stationeryList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Stationery')
        .toList());

    healthcareList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Healthcare')
        .toList());

    servicesList.value = _sortByArrayLength(filteredDocs
        .where((doc) => doc['itemType'] == 'Services')
        .toList());
  });
}

// Sort the list from highest to lowest based on the combined number of likes and viewby
List<Map<String, dynamic>> _sortByArrayLength(List<Map<String, dynamic>> list) {
  list.sort((a, b) {
    int aLikes = (a['likes'] as List<dynamic>).length;
    int bLikes = (b['likes'] as List<dynamic>).length;
    
    int aViewby = (a['viewedBy'] as List<dynamic>).length;
    int bViewby = (b['viewedBy'] as List<dynamic>).length;

    // Combine likes and viewby
    int aTotal = aLikes + aViewby;
    int bTotal = bLikes + bViewby;

    // Sort based on the combined total of likes and viewby
    return bTotal.compareTo(aTotal);
  });
  return list;
}




  void unsubscribe() {
    subscription?.pause();
  }

  @override
  void onClose() {
    unsubscribe();
    super.onClose();
  }
}