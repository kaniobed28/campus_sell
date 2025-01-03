// models/intermediary.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Intermediary {
  final String intermediaryId;
  final String name;
  final String email;
  final String phone;
  final Timestamp createdAt;

  Intermediary({
    required this.intermediaryId,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdAt,
  });

  factory Intermediary.fromDocument(DocumentSnapshot doc) {
    return Intermediary(
      intermediaryId: doc.id,
      name: doc['name'] ?? '',
      email: doc['email'] ?? '',
      phone: doc['phone'] ?? '',
      createdAt: doc['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
    };
  }
}
