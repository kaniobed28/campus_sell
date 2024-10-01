import 'package:flutter/material.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:intl/intl.dart'; // For formatting the timestamp

class TransactionDetailsPage extends StatelessWidget {
  final TransactionModel transaction;

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
              Text('Transaction Date: ${DateFormat.yMMMd().add_jm().format(transaction.timestamp.toDate())}'),
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
            ],
          ),
        ),
      ),
    );
  }
}
