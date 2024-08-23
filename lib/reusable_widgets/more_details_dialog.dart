import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MoreDetailsDialog extends StatelessWidget {
  final String title;
  final String brandName;
  final String price;
  final String phone;
  final String city;
  final String hostel;
  final String university;
  final String itemType;
  final String socialMedia;

  const MoreDetailsDialog({
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight,
            ),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildDetailRow("Item Name:", title),
                        _buildDetailRow("Owner's Shop:", brandName),
                        _buildDetailRow("Price:", "Gh¢ $price"),
                        _buildDetailRow("Phone:", phone),
                        _buildDetailRow("City:", city),
                        _buildDetailRow("Hostel/Address:", hostel),
                        _buildDetailRow("University:", university),
                        _buildDetailRow("Category:", itemType),
                        _buildDetailRow("Social Media:", socialMedia),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2, // Allow up to 2 lines before ellipsis
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar(
                "Copied to Clipboard",
                value,
                duration: const Duration(seconds: 1, milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}
