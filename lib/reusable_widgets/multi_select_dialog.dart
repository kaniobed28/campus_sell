import 'package:flutter/material.dart';

class MultiSelectDialog extends StatefulWidget {
  final List<dynamic> items;
  final List<String> initialSelectedItems;

  MultiSelectDialog({required this.items, required this.initialSelectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.initialSelectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select From Here'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  isChecked! ? _selectedItems.add(item) : _selectedItems.remove(item);
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          },
        )
      ],
    );
  }
}
