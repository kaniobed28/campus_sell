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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle(context),
              const SizedBox(height: 20),
              _buildDetailsCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildDetailItem("Owner's Shop", brandName),
            _buildDetailItem("Price", "Gh¢ $price"),
            _buildDetailItem("Phone", phone),
            _buildDetailItem("City", city),
            _buildDetailItem("Hostel/Address", hostel),
            _buildDetailItem("University", university),
            _buildDetailItem("Category", itemType),
            _buildDetailItem("Social Media", socialMedia),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
