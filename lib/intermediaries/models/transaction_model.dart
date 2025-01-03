// lib/models/transaction_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionItem {
  final String itemId;
  final String itemName;
  final int quantity;
  final double price;
  final Timestamp? timestamp; // Make timestamp nullable
  final Timestamp? statusChangedTime; // Make statusChangedTime nullable

  TransactionItem({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.price,
    this.timestamp, // Nullable parameter
    this.statusChangedTime, // Nullable parameter
  });

  factory TransactionItem.fromMap(Map<String, dynamic> map) {
    return TransactionItem(
      itemId: map['itemId'],
      itemName: map['itemName'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
      timestamp: map['timestamp'], // Initialize timestamp
      statusChangedTime: map['statusChangedTime'], // Initialize statusChangedTime
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'quantity': quantity,
      'price': price,
      'timestamp': timestamp, // Include timestamp in map
      'statusChangedTime': statusChangedTime, // Include statusChangedTime in map
    };
  }
}

class TransactionModel {
  final String transactionId;
  final String userId;
  final String intermediaryId;
  final List<TransactionItem> items;
  final String status;
  late final String intermediaryMessage;
  late final double intermediaryCharges;
  final Timestamp? timestamp; // Make transaction timestamp nullable

  TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.intermediaryId,
    required this.items,
    required this.status,
    required this.intermediaryMessage,
    required this.intermediaryCharges,
    this.timestamp, // Nullable parameter
  });

  factory TransactionModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TransactionModel(
      transactionId: doc.id,
      userId: data['userId'],
      intermediaryId: data['intermediaryId'],
      items: List<TransactionItem>.from(
        (data['items'] as List).map((item) => TransactionItem.fromMap(item)),
      ),
      status: data['status'],
      intermediaryMessage: data['intermediaryMessage'] ?? '',
      intermediaryCharges: data['intermediaryCharges']?.toDouble() ?? 0.0,
      timestamp: data['timestamp'], // Initialize nullable transaction timestamp
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'intermediaryId': intermediaryId,
      'items': items.map((item) => item.toMap()).toList(),
      'status': status,
      'intermediaryMessage': intermediaryMessage,
      'intermediaryCharges': intermediaryCharges,
      'timestamp': timestamp, // Include nullable transaction timestamp in map
    };
  }
}
