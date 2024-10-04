import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:intl/intl.dart'; // For formatting the timestamp
import 'package:get/get.dart'; // Import GetX for controller usage

class TransactionDetailsPage extends StatelessWidget {
  final TransactionModel transaction;
  final TransactionController transactionController = Get.put(TransactionController());

  TransactionDetailsPage({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: const Color(0xFFFBD300),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction ID: ${transaction.transactionId}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Status: ${transaction.status}'),
              const SizedBox(height: 10),
              Text('User ID: ${transaction.userId}'),
              const SizedBox(height: 10),
              Text('Intermediary ID: ${transaction.intermediaryId}'),
              const SizedBox(height: 10),
              Text('Intermediary Message: ${transaction.intermediaryMessage.isEmpty ? 'N/A' : transaction.intermediaryMessage}'),
              const SizedBox(height: 10),
              Text('Intermediary Charges: \$${transaction.intermediaryCharges.toStringAsFixed(2)}'),
              const SizedBox(height: 10),
              Text('Transaction Date: ${DateFormat.yMMMd().add_jm().format(transaction.timestamp!.toDate())}'),
              const SizedBox(height: 20),
              const Text(
                'Items:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transaction.items.length,
                itemBuilder: (context, index) {
                  final item = transaction.items[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(item.itemName),
                    subtitle: Text('Quantity: ${item.quantity}, Price: \$${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Button logic based on the status
              if (transaction.status == 'accepted') 
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              bool success = await transactionController.updateTransaction(
                                transactionId: transaction.transactionId,
                                status: 'transport', // Change status to 'transport'
                              );
                              if (success) {
                                Get.back(); // Go back if the update was successful
                              }
                            },
                            child: Text('Transport'),
                          ),
                        ),
                        const SizedBox(width: 10), // Add space between buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              bool success = await transactionController.updateTransaction(
                                transactionId: transaction.transactionId,
                                status: 'stopped', // Change status to 'stopped'
                              );
                              if (success) {
                                Get.back(); // Go back if the update was successful
                              }
                            },
                            child: Text('Stop'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Additional spacing below buttons
                  ],
                )
              else if (transaction.status == 'transport') // When status is 'transport'
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool success = await transactionController.updateTransaction(
                          transactionId: transaction.transactionId,
                          status: 'received', // Change status to 'received'
                        );
                        if (success) {
                          Get.back(); // Go back if the update was successful
                        }
                      },
                      child: Text('Acknowledge Receipt'),
                    ),
                    const SizedBox(height: 20), // Additional spacing below the button
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
