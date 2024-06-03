import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
// this function updates both the additional info and the items collection together
  Future<void> updateWithAddInfo() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    AuthController authController = Get.put(AuthController());
    if (authController.isAuthenticated.value) {
      DocumentSnapshot<Map<String, dynamic>> snapshota = await firebaseFirestore
          .collection("add_info")
          .doc(authController.uid.string)
          .get();
      Map<String, dynamic> data = snapshota.data() as Map<String, dynamic>;

      QuerySnapshot snapshot = await firebaseFirestore
          .collection("items")
          .where("ownerId", isEqualTo: authController.uid.string)
          .get();
      snapshot.docs.forEach((element) {
        firebaseFirestore.collection("items").doc(element.id).update(data);
      });
    } else {}
  }

  Future<Map<String, dynamic>?> getDocumentById(String docId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('add_info').doc(docId).get();
      if (snapshot.exists) {
        // print('Document data: ${snapshot.data()}');
        return snapshot.data();
      } else {
        // print('Document does not exist');
        return null;
      }
    } catch (e) {
      // print('Error getting document: $e');
      throw e;
    }
  }
}
