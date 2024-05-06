import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addDataToFirestore(Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).set(data);
        print('Data added successfully');
      } else {
        print('Error: Data is empty or null');
      }
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<void> updateDataInFirestore(String documentId, Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).update(data);
        print('Data updated successfully');
      } else {
        print('Error: Data is empty or null');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }
}
