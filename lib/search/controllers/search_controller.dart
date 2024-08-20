import 'package:campus_sell/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


// I used capitalized first because that is how I stored them.

// when i search, the like system was not working and I forgot I added the item id programmatically not to the database so I have now added it also to the search results.
class SearchedController extends GetxController {
  RxList<dynamic> searchResults = [].obs;

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
    for (var element in querySnapshot.docs) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      data['id'] = element.id; // Add the element.id to the data map
      searchResults.add(data);
      // print(data.length);
      // print(data);
    }
  }


  Future<void> searchItemsName(String query) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  if (query.isEmpty) {
    searchResults.clear();
    return;
  }

  try {
    QuerySnapshot snapshot = await firebaseFirestore
        .collection('items')
        .where('itemName', isGreaterThanOrEqualTo: query.capitalizeFirst)
        .where('itemName', isLessThanOrEqualTo: '${query.capitalizeFirst}\uf8ff')
        .get();

    searchResults.value = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Add the doc.id to the data map
      return data;
    }).toList();
  } catch (e) {
    Get.snackbar('Error', e.toString());
  }
}

}




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // SearchedController().search(
  //   "",
  //   "",
  //   "",
  //   "",
  //   "KNUST",
  //   "",
  // );
  SearchedController controller = SearchedController();
  await controller.searchItemsName("miL");
  print(controller.searchResults); // Debugging print statement
}
