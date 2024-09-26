// widgets/intermediary_response_listener.dart


import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntermediaryResponseListener extends StatelessWidget {
  final String userId;
  final String itemId;
  final TransactionController _transactionController = Get.find<TransactionController>();

   IntermediaryResponseListener({Key? key, required this.userId, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TransactionModel?>(
      stream: _transactionController.getLatestTransaction(userId, itemId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            final transaction = snapshot.data!;
            if (transaction.status == 'accepted') {
              // Prompt user to confirm transaction
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showConfirmationDialog(context, transaction);
              });
            } else if (transaction.status == 'declined') {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.snackbar('Transaction Declined', 'Your request was declined by the intermediary.');
              });
            }
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showConfirmationDialog(BuildContext context, TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transaction Accepted'),
          content: const Text('The intermediary has accepted your request. Do you want to proceed with the transaction?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Update transaction status to 'confirmed'
                await _transactionController.updateTransactionStatus(transaction.transactionId, 'confirmed');
                Get.back(); // Close the dialog
                Get.snackbar('Success', 'Transaction confirmed and proceeding.');
                // TODO: Implement actual transaction logic here
              },
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBD300),
              ),
            ),
          ],
        );
      },
    );
  }
}
