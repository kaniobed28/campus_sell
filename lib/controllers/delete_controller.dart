import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  
  Stream<QuerySnapshot<Map<String, dynamic>>> listForShopItems(String ownerId) {
  return FirebaseFirestore.instance
      .collection('items')
      .where('ownerId', isEqualTo: ownerId)
      .snapshots();
}
}