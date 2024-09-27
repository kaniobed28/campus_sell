// lib/screens/intermediary_transaction_page.dart


import 'package:campus_sell/intermediaries/controllers/inmediaries_controller.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntermediaryTransactionPage extends StatelessWidget {
  final IntermediaryController _intermediaryController = Get.put(IntermediaryController());
  final String intermediaryId; // Intermediary ID to fetch transactions

  IntermediaryTransactionPage({super.key, required this.intermediaryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Transactions'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: _intermediaryController.getIntermediaryTransactions(intermediaryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final transactions = snapshot.data!;
          if (transactions.isEmpty) {
            return const Center(child: Text('No transactions assigned.'));
          }
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final txn = transactions[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Transaction ID: ${txn.transactionId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${txn.status}'),
                      Text('Total Items: ${txn.items.length}'),
                      Text('Total Price: Gh¢${txn.items.fold<double>(0, (sum, item) => sum + (item.price * item.quantity)).toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: txn.status == 'pending'
                      ? ElevatedButton(
                          onPressed: () {
                            _showAcceptRejectDialog(txn);
                          },
                          child: const Text('Manage'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                        )
                      : Text(
                          txn.status.capitalizeFirst ?? txn.status,
                          style: TextStyle(
                            color: txn.status == 'accepted' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  onTap: () {
                    // Optionally, navigate to a detailed transaction page
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAcceptRejectDialog(TransactionModel txn) {
    Get.defaultDialog(
      title: 'Manage Transaction',
      content: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Message'),
            onChanged: (value) {
              // Handle message input
              txn.intermediaryMessage = value;
            },
            maxLines: 3,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Charges'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              // Handle charges input
              txn.intermediaryCharges = double.tryParse(value) ?? 0.0;
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Accept the transaction
                  _intermediaryController.acceptTransaction(
                    transactionId: txn.transactionId,
                    message: txn.intermediaryMessage,
                    charges: txn.intermediaryCharges,
                  );
                  Get.back();
                },
                child: const Text('Accept'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              ElevatedButton(
                onPressed: () {
                  // Reject the transaction
                  _intermediaryController.rejectTransaction(
                    transactionId: txn.transactionId,
                    message: txn.intermediaryMessage,
                  );
                  Get.back();
                },
                child: const Text('Reject'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
