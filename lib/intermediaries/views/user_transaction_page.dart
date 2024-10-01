import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:campus_sell/intermediaries/views/transaction_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';

class UserTransactionPage extends StatelessWidget {
  final TransactionController _transactionController = Get.find<TransactionController>();
  final String userId;

  UserTransactionPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Transactions'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: StreamBuilder<List<TransactionModel>>(
        stream: _transactionController.getUserTransactions(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching transactions: ${snapshot.error}'));
          }

          final transactions = snapshot.data ?? [];
          if (transactions.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          }

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final txn = transactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: ListTile(
                  title: Text('Transaction ID: ${txn.transactionId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${txn.status}'),
                      Text('Total Items: ${txn.items.length}'),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => TransactionDetailsPage(transaction: txn)); // Navigate to details page
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


  Widget _buildActionButton(TransactionModel txn) {
    if (txn.status == 'accepted') {
      return ElevatedButton(
        onPressed: () {
          _showContinueTerminateDialog(txn);
        },
        child: const Text('Continue/Terminate'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      );
    } else if (txn.status == 'pending') {
      return const Text('Awaiting Intermediary', style: TextStyle(color: Colors.orange));
    } else if (txn.status == 'rejected') {
      return const Text('Transaction Rejected', style: TextStyle(color: Colors.red));
    }
    return Container();
  }

  void _showContinueTerminateDialog(TransactionModel txn) {
      final TransactionController _transactionController = Get.find<TransactionController>();

    Get.defaultDialog(
      title: 'Transaction Options',
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Implement continue transaction logic
              // e.g., calling an appropriate method to continue the transaction
              Get.back();
              Get.snackbar('Continue', 'You have chosen to continue the transaction.');
            },
            child: const Text('Continue'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement terminate transaction logic
              _transactionController.updateTransaction(transactionId: txn.transactionId, status: 'terminated');
              Get.back();
              Get.snackbar('Terminated', 'You have terminated the transaction.');
            },
            child: const Text('Terminate'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

