// lib/screens/select_intermediary_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectIntermediaryScreen extends StatefulWidget {
  final String userId;
  final Function(String) onSelect;

  const SelectIntermediaryScreen({super.key, required this.userId, required this.onSelect});

  @override
  _SelectIntermediaryScreenState createState() => _SelectIntermediaryScreenState();
}

class _SelectIntermediaryScreenState extends State<SelectIntermediaryScreen> {
  String? selectedIntermediaryId;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('intermediaries');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Intermediary'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final intermediaries = snapshot.data!.docs;
          if (intermediaries.isEmpty) {
            return const Center(child: Text('No intermediaries available.'));
          }
          return Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Choose Intermediary'),
                value: selectedIntermediaryId,
                items: intermediaries.map((doc) {
                  return DropdownMenuItem<String>(
                    value: doc.id,
                    child: Text(doc['name'] ?? 'Unnamed'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIntermediaryId = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedIntermediaryId != null
                    ? () {
                        widget.onSelect(selectedIntermediaryId!);
                        Get.back();
                      }
                    : null,
                child: const Text('Select'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBD300),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
