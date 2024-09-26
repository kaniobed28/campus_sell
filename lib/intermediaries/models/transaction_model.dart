// models/transaction_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transactionId;
  final String userId;
  final String itemId;
  final String intermediaryId;
  final String status;
  final Timestamp timestamp;

  TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.itemId,
    required this.intermediaryId,
    required this.status,
    required this.timestamp,
  });

  factory TransactionModel.fromDocument(DocumentSnapshot doc) {
    return TransactionModel(
      transactionId: doc.id,
      userId: doc['userId'] ?? '',
      itemId: doc['itemId'] ?? '',
      intermediaryId: doc['intermediaryId'] ?? '',
      status: doc['status'] ?? 'pending',
      timestamp: doc['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'itemId': itemId,
      'intermediaryId': intermediaryId,
      'status': status,
      'timestamp': timestamp,
    };
  }
}
