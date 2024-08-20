import 'package:campus_sell/controllers/edit_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemEditForm extends StatelessWidget {
  final String itemId; // Required itemId
  final String fieldName;
  final TextEditingController textController; // Required TextEditingController
  final RegExp validationPattern; // Required RegExp for validation
  final String validationMessage; // Error message if validation fails
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  // Constructor to accept itemId, TextEditingController, RegExp, and validation message
  ItemEditForm({
    required this.itemId,
    required this.textController,
    required this.validationPattern,
    this.validationMessage = 'Invalid input', 
    required this.fieldName,
  });

  @override
  Widget build(BuildContext context) {
   EditItemController editItemController = Get.put(EditItemController());
    return Form(
      key: _formKey, // Assign the form key
      child: Column(
        children: [
          TextFormField(
            controller: textController, // Use the passed TextEditingController
            decoration: InputDecoration(
              labelText: 'Enter new information',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              } else if (!validationPattern.hasMatch(value)) {
                return validationMessage;
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                // Handle the save operation here using itemId and textController
                String editedText = textController.text;
                // Perform any operation with itemId and editedText
               await editItemController.updateField(itemId, fieldName, editedText);
                Get.toNamed('/'); // Close the dialog
                Get.snackbar("Success", "Information updated for item $itemId to: $editedText");
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
