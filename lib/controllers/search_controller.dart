import 'package:campus_sell/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SearchedController extends GetxController {
  List<dynamic> searchResults = [];

  Future<void> search(
      String itemName,
      String itemType,
      String brandName,
      String city,
      String university,
      String hostel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    searchResults.clear(); // clearing the search results so that double search will not make the list more than required.
    Query col = firebaseFirestore.collection("items");

    if (itemName.isNotEmpty) {
      // Perform actions for non-empty and non-'select' itemName
      col = col.where("itemName",
          isEqualTo: itemName.toString().capitalizeFirst);
    }

    if (itemType.isNotEmpty && itemType.split(" ")[0] != 'select') {
      // Perform actions for non-empty and non-'select' itemType
      col = col.where(
          "itemType", isEqualTo: itemType.toString().capitalizeFirst);
    }

    if (brandName.isNotEmpty ) {
      // Perform actions for non-empty and non-'select' brandName
      col = col.where("brand",
          isEqualTo: brandName.toString().capitalizeFirst);
    }

    if (city.isNotEmpty && city != 'select'.split(" ")[0]) {
      // Perform actions for non-empty and non-'select' city
      col = col.where("city", isEqualTo: city.toString().capitalizeFirst);
    }

    if (university.isNotEmpty && university.split(" ")[0] != 'Select') {
      // Perform actions for non-empty and non-'select' university
      col = col.where("university", isEqualTo: university);
    }

    if (hostel.isNotEmpty ) {
      // Perform actions for non-empty and non-'select' hostel
      col = col.where(
          "hostel", isEqualTo: hostel.toString().capitalizeFirst);
    }

    QuerySnapshot querySnapshot = await col.get();
    querySnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      searchResults.add(data);
      print(data.length);
      print(data);
    });
  }
}

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SearchedController().search(
    "Oceanic",
    "electronic",
    "obed",
    "",
    "KNUST",
    "new hostel",
  );
}