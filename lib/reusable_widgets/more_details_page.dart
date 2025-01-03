import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareDetails,
          ),
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
            children: [
              _buildTitle(context),
              const SizedBox(height: 20),
              _buildDetailsCard(context),
              const SizedBox(height: 20),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Title widget
  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  /// Card displaying the item details
  Widget _buildDetailsCard(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDetailItem(
              context,
              label: "Owner's Shop",
              value: brandName,
              icon: Icons.store,
            ),
            _buildDetailItem(
              context,
              label: "Price",
              value: "Gh¢ $price",
              icon: Icons.price_check,
            ),
            _buildDetailItem(
              context,
              label: "Phone",
              value: phone,
              icon: Icons.phone,
            ),
            _buildDetailItem(
              context,
              label: "City",
              value: city,
              icon: Icons.location_city,
            ),
            _buildDetailItem(
              context,
              label: "Hostel/Address",
              value: hostel,
              icon: Icons.home,
            ),
            _buildDetailItem(
              context,
              label: "University",
              value: university,
              icon: Icons.school,
            ),
            _buildDetailItem(
              context,
              label: "Category",
              value: itemType,
              icon: Icons.category,
            ),
            _buildDetailItem(
              context,
              label: "Social Media",
              value: socialMedia,
              icon: Icons.public,
            ),
          ],
        ),
      ),
    );
  }

  /// A single row of label & value + optional icon
  Widget _buildDetailItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: colorScheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  /// Buttons for calling or opening social media
  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _callPhone,
          icon: const Icon(Icons.call),
          label: const Text("Call"),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _openSocialMedia,
          icon: const Icon(Icons.public),
          label: const Text("Open Social Media"),
        ),
      ],
    );
  }

  /// Share details through a snackbar (can be adapted for any share method)
  void _shareDetails() {
    final details = '''
Title: $title
Owner's Shop: $brandName
Price: Gh¢ $price
Phone: $phone
City: $city
Hostel: $hostel
University: $university
Category: $itemType
Social Media: $socialMedia
    ''';
    Get.snackbar(
      "Share",
      "Copy the details to share:\n\n$details",
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 6),
    );
  }

  /// Attempt to call the phone number
  void _callPhone() async {
    final uri = Uri.parse("tel:$phone");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        "Error",
        "Unable to call the number.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Attempt to open the social media link
  void _openSocialMedia() async {
    if (socialMedia.isNotEmpty) {
      final uri = Uri.parse(socialMedia);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Get.snackbar(
          "Error",
          "Unable to open the social media link.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "No social media link provided.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
