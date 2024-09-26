// widgets/manage_item_dialog.dart


import 'package:campus_sell/intermediaries/controllers/inmediaries_controller.dart';
import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageItemDialog extends StatefulWidget {
  final String userId;
  final String itemId;

  const ManageItemDialog({Key? key, required this.userId, required this.itemId}) : super(key: key);

  @override
  _ManageItemDialogState createState() => _ManageItemDialogState();
}

class _ManageItemDialogState extends State<ManageItemDialog> {
  final IntermediaryController _intermediaryController = Get.find<IntermediaryController>();
  final TransactionController _transactionController = Get.find<TransactionController>();
  String? _selectedIntermediaryId;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select an Intermediary'),
      content: Obx(() {
        if (_intermediaryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_intermediaryController.intermediaries.isEmpty) {
          return const Text('No intermediaries available.');
        }
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Intermediary',
            border: OutlineInputBorder(),
          ),
          items: _intermediaryController.intermediaries.map((intermediary) {
            return DropdownMenuItem<String>(
              value: intermediary.intermediaryId,
              child: Text(intermediary.name),
            );
          }).toList(),
          value: _selectedIntermediaryId,
          onChanged: (value) {
            setState(() {
              _selectedIntermediaryId = value;
            });
          },
          validator: (value) => value == null ? 'Please select an intermediary' : null,
        );
      }),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting
              ? null
              : () async {
                  if (_selectedIntermediaryId == null) {
                    Get.snackbar('Error', 'Please select an intermediary.');
                    return;
                  }
                  setState(() {
                    _isSubmitting = true;
                  });
                  await _transactionController.createTransaction(
                    userId: widget.userId,
                    itemId: widget.itemId,
                    intermediaryId: _selectedIntermediaryId!,
                  );
                  setState(() {
                    _isSubmitting = false;
                  });
                  Get.back();
                },
          child: _isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Submit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFBD300),
          ),
        ),
      ],
    );
  }
}
