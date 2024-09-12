import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  final authController = Get.find<AuthController>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String? brandName; // Nullable
  String? cityName;  // Nullable
  String? universityName; // Nullable
  String? addressName; // Nullable
  String? phoneNumber; // Nullable
  String? socialMedia; // Nullable
  String? countryName; // Nullable

  Future<Map<String, dynamic>?> getDocumentById(String docId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('add_info').doc(docId).get();
      
      if (snapshot.exists) {
        // Assigning data to variables
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>? ?? {};

        brandName = data['brand'] as String?;
        cityName = data['city'] as String?;
        universityName = data['university'] as String?;
        addressName = data['hostel'] as String?;
        phoneNumber = data['phone'] as String?;
        socialMedia = data['socialMedia'] as String?;
        countryName = data['country'] as String?; // Added country assignment

        return data;
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Handle error
      throw e;
    }
  }

  Future<void> addDataToFirestore(
      Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).set(data);
        // print('Data added successfully');
      } else {
        // print('Error: Data is empty or null');
      }
    } catch (e) {
      // print('Error adding data: $e');
    }
  }

  Future<void> updateDataInFirestore(
      Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).update(data);
        // print('Data updated successfully');
      } else {
        // print('Error: Data is empty or null');
      }
    } catch (e) {
      // print('Error updating data: $e');
    }
  }

  Future<void> updateWithAddInfo() async {
    if (authController.isAuthenticated.value) {
      Map<String, dynamic>? data = await getDocumentById(authController.uid.string);
      if (data != null) {
        QuerySnapshot snapshot = await firebaseFirestore
            .collection("items")
            .where("ownerId", isEqualTo: authController.uid.string)
            .get();
        snapshot.docs.forEach((element) {
          firebaseFirestore.collection("items").doc(element.id).update(data);
        });
      }
    }
  }

  Future<void> updateAnItemWithAddInfo(String itemName) async {
    if (authController.isAuthenticated.value) {
      Map<String, dynamic>? data = await getDocumentById(authController.uid.string);
      if (data != null) {
        QuerySnapshot snapshot = await firebaseFirestore
            .collection("items")
            .where("ownerId", isEqualTo: authController.uid.string)
            .where("itemName", isEqualTo: itemName)
            .get();
        for (var element in snapshot.docs) {
          firebaseFirestore.collection("items").doc(element.id).update(data);
        }
      }
    }
  }
}
