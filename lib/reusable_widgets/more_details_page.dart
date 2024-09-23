import 'package:campus_sell/dashboard/ago_tech_product_details_card.dart';
import 'package:campus_sell/reusable_widgets/custom_copy_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class MoreDetailsPage extends StatelessWidget {
  final String title;
  final String brandName;
  final String price;
  final String phone;
  final String city;
  final String hostel;
  final String university;
  final String itemType;
  final String socialMedia;

  const MoreDetailsPage({
    Key? key,
    required this.title,
    required this.brandName,
    required this.price,
    required this.phone,
    required this.city,
    required this.hostel,
    required this.university,
    required this.itemType,
    required this.socialMedia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildDetailsGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsGrid() {
    final details = {
      "Owner's Shop": brandName,
      "Price": "\$ $price",
      "Phone": phone,
      "City": city,
      "Hostel/Address": hostel,
      "University": university,
      "Category": itemType,
      "Social Media": socialMedia,
    };

    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context, index) {
        final key = details.keys.elementAt(index);
        final value = details[key]!;
        return _buildDetailItem(key, value);
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.blueAccent),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              CopyIconButton(value: value, label: label),
            ],
          ),
        ),
      ],
    );
  }
}
