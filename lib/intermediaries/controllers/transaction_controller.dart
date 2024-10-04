// lib/controllers/transaction_controller.dart

import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactionCollection = FirebaseFirestore.instance.collection('transactions');

  // Stream to listen to user's transactions
  Stream<List<TransactionModel>> getUserTransactions(String userId) {
  return _transactionCollection
      .where('userId', isEqualTo: userId)
      .orderBy('statusChangedTime', descending: true) // Sort by statusChangedTime
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => TransactionModel.fromDocument(doc))
          .toList());
}

  // Create a new transaction during checkout
  Future<void> createTransaction({
    required String userId,
    required String intermediaryId,
    required List<TransactionItem> items,
  }) async {
    try {
      await _transactionCollection.add({
        'userId': userId,
        'intermediaryId': intermediaryId,
        'items': items.map((item) => item.toMap()).toList(),
        'status': 'pending',
        'intermediaryMessage': '',
        'intermediaryCharges': 0.0,
        'timestamp': FieldValue.serverTimestamp(),
        'statusChangedTime':FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to create transaction: $e');
    }
  }

  // Update transaction status and intermediary details
  Future<bool> updateTransaction({
  required String transactionId,
  String? status,
  String? intermediaryMessage,
  double? intermediaryCharges,
}) async {
  try {
    Map<String, dynamic> updateData = {};
   if (status != null) {
      updateData['status'] = status;
      updateData['statusChangedTime'] = FieldValue.serverTimestamp(); // Update status changed time
    }
    if (intermediaryMessage != null) updateData['intermediaryMessage'] = intermediaryMessage;
    if (intermediaryCharges != null) updateData['intermediaryCharges'] = intermediaryCharges;

    await _transactionCollection.doc(transactionId).update(updateData);
    return true; // Indicate success
  } catch (e) {
    Get.snackbar('Error', 'Failed to update transaction: $e');
    return false; // Indicate failure
  }
}

}
