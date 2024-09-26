// controllers/transaction_controller.dart

import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _transactionCollection = FirebaseFirestore.instance.collection('transactions');

  // Creates a new transaction
  Future<void> createTransaction({
    required String userId,
    required String itemId,
    required String intermediaryId,
  }) async {
    try {
      await _transactionCollection.add({
        'userId': userId,
        'itemId': itemId,
        'intermediaryId': intermediaryId,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Transaction request sent to intermediary.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create transaction.');
      print('Error creating transaction: $e');
    }
  }

  // Listens to the latest transaction for a specific user and item
  Stream<TransactionModel?> getLatestTransaction(String userId, String itemId) {
    return _transactionCollection
        .where('userId', isEqualTo: userId)
        .where('itemId', isEqualTo: itemId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return TransactionModel.fromDocument(snapshot.docs.first);
      }
      return null;
    });
  }

  // Updates the status of a transaction
  Future<void> updateTransactionStatus(String transactionId, String newStatus) async {
    try {
      await _transactionCollection.doc(transactionId).update({
        'status': newStatus,
      });
      Get.snackbar('Success', 'Transaction status updated.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update transaction status.');
      print('Error updating transaction: $e');
    }
  }
}
