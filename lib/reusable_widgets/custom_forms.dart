import 'package:flutter/material.dart';

class NameForm extends StatelessWidget {
  TextEditingController? nameController;

  NameForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this form field';
        }
        return null;
      },
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}

class DescriptionForm extends StatelessWidget {
  TextEditingController? nameController;

  DescriptionForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this form field';
        }
        return null;
      },
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}

class PriceForm extends StatelessWidget {
  TextEditingController? nameController;

  PriceForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this form field';
        }
        return null;
      },
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final TextEditingController itemTypeController;
  final String labelText;
  final List<DropdownMenuItem<String>> items;

  const CustomDropdownButtonFormField({
    super.key,
    required this.itemTypeController,
    this.labelText = "Product Type",
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: itemTypeController.text.isNotEmpty ? itemTypeController.text : null,
      items: items,
      onChanged: (val) {
        itemTypeController.text = val!;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
