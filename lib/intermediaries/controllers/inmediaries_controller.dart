// lib/controllers/intermediary_controller.dart

import 'package:campus_sell/intermediaries/models/intermediaries_model.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class IntermediaryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactionCollection = FirebaseFirestore.instance.collection('transactions');

  // Stream to listen to transactions assigned to the intermediary
  Stream<List<TransactionModel>> getIntermediaryTransactions(String intermediaryId) {
    return _transactionCollection
        .where('intermediaryId', isEqualTo: intermediaryId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromDocument(doc))
            .toList());
  }

  // Accept a transaction
  Future<void> acceptTransaction({
    required String transactionId,
    required String message,
    required double charges,
  }) async {
    try {
      await _transactionCollection.doc(transactionId).update({
        'status': 'accepted',
        'intermediaryMessage': message,
        'intermediaryCharges': charges,
      });
      Get.snackbar('Success', 'Transaction accepted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept transaction: $e');
    }
  }

  // Reject a transaction
  Future<void> rejectTransaction({
    required String transactionId,
    required String message,
  }) async {
    try {
      await _transactionCollection.doc(transactionId).update({
        'status': 'rejected',
        'intermediaryMessage': message,
      });
      Get.snackbar('Success', 'Transaction rejected');
    } catch (e) {
      Get.snackbar('Error', 'Failed to reject transaction: $e');
    }
  }


  final CollectionReference _intermediaryCollection = FirebaseFirestore.instance.collection('intermediaries');

  // Method to add an intermediary
  Future<void> addIntermediary(Intermediary intermediary) async {
    try {
      await _intermediaryCollection.doc(intermediary.intermediaryId).set(intermediary.toMap());
    } catch (e) {
      throw Exception('Failed to add intermediary: $e');
    }
  }
}
