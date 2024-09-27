// lib/screens/intermediary_screen.dart

import 'package:campus_sell/intermediaries/views/intermediary_transaction_page.dart';
import 'package:flutter/material.dart';

class IntermediaryScreen extends StatelessWidget {
  final String intermediaryId; // Pass the intermediary's ID

  const IntermediaryScreen({super.key, required this.intermediaryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intermediary Dashboard'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: IntermediaryTransactionPage(intermediaryId: intermediaryId),
    );
  }
}
