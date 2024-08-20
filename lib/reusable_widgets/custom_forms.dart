import 'package:flutter/material.dart';

class NameForm extends StatelessWidget {
  TextEditingController?  nameController;

   NameForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this form field';
          }
          return null;
      },
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        )
      ),
    );
  }
}
class DescriptionForm extends StatelessWidget {
  TextEditingController?  nameController;

   DescriptionForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
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
          borderRadius: BorderRadius.all(Radius.circular(15))
        )
      ),
    );
  }
}
class PriceForm extends StatelessWidget {
  TextEditingController?  nameController;

   PriceForm({super.key, this.nameController });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
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
          borderRadius: BorderRadius.all(Radius.circular(15))
        )
      ),
    );
  }
}


class CustomDropdownButtonFormField extends StatelessWidget {
  final TextEditingController itemTypeController;
  final String labelText;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.itemTypeController,
    this.labelText = "Product Type",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: itemTypeController.text.isNotEmpty ? itemTypeController.text : null,
      items: const [
        DropdownMenuItem<String>(
          value: "",
          child: Text("Select Item Type"),
        ),
        DropdownMenuItem<String>(
          value: "fashion",
          child: Text("Fashion"),
        ),
        DropdownMenuItem<String>(
          value: "food",
          child: Text("Food"),
        ),
        DropdownMenuItem<String>(
          value: "electronic",
          child: Text("Electronic"),
        ),
        DropdownMenuItem<String>(
          value: "beauty",
          child: Text("Beauty Products"),
        ),
        DropdownMenuItem<String>(
          value: "sports",
          child: Text("Sports Equipment"),
        ),
        DropdownMenuItem<String>(
          value: "stationery",
          child: Text("Stationery"),
        ),
        DropdownMenuItem<String>(
          value: "healthcare",
          child: Text("Healthcare Products"),
        ),
        DropdownMenuItem<String>(
          value: "jewelry",
          child: Text("Jewelry"),
        ),
        DropdownMenuItem<String>(
          value: "kitchen",
          child: Text("Kitchen Appliances"),
        ),
        DropdownMenuItem<String>(
          value: "services",
          child: Text("Services"),
        ),
        DropdownMenuItem<String>(
          value: "others",
          child: Text("Others"),
        ),
      ],
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
