import 'package:campus_sell/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetItemByIdController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 
  Future<Map<String, dynamic>?> getDocumentById(String docId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('items').doc(docId).get();
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetItemByIdController controller = GetItemByIdController();
  String docId = '09qvAQDSia3QGtMzoAeF';
  Map<String, dynamic>? document = await controller.getDocumentById(docId);
  print(document);
}