
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ListSearchItems extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> soldItems = [];

  Future<void> listSearchItems(
    String itemType,
    String university,
    String city,
    String? brand,
    String? hostel,
  ) async {
    final CollectionReference itemsCollectionRef =
        firebaseFirestore.collection('items');

    // Construct the query for add_info collection based on the provided parameters
    Query<Object?> itemQuery = itemsCollectionRef;
    if (university != "Select University" && university.isNotEmpty) {
      // print("object");
      itemQuery = itemQuery.where("university", isEqualTo: university);
    }
    if (city != "Select City" && city.isNotEmpty) {
      itemQuery = itemQuery.where("city", isEqualTo: city);
      QuerySnapshot querySnapshot = await itemQuery.get();
      // print(city);
    }
    if (brand != null && brand.isNotEmpty) {
      // print("object");
      itemQuery = itemQuery.where("brand", isEqualTo: brand);
    }
    if (hostel != null && hostel.isNotEmpty) {
      // print("object");
      itemQuery = itemQuery.where("hostel", isEqualTo: hostel);
    }

    // Get the documents from add_info collection

    // Construct the query for items collection based on ownerIds and itemType

    if (itemType != "Select Item Type" && itemType.isNotEmpty) {
      itemQuery = itemQuery.where("itemType", isEqualTo: itemType);
    }

    // Get the documents from items collection based on the constructed query
    final itemsQuerySnapshot = await itemQuery.get();

    // Extract data from documents and add to soldItems list
    soldItems = itemsQuerySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // print(soldItems.length); // Print the length of soldItems
  }
}
