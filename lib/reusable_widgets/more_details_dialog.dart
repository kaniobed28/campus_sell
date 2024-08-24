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
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDetailsGrid(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Close',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsGrid() {
    final details = {
      "Owner's Shop": brandName,
      "Price": "Gh¢ $price",
      "Phone": phone,
      "City": city,
      "Hostel/Address": hostel,
      "University": university,
      "Category": itemType,
      "Social Media": socialMedia,
    };

    return GridView.builder(
      shrinkWrap: true,
      itemCount: details.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
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
          child: GestureDetector(
            
            onTap: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar("Copied", "$label copied to clipboard");
            },
            child: Text(
              value,
              style: const TextStyle(color: Colors.blueAccent),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            
          ),
        ),
        // const Icon(Icons.copy, size: 18),
        // close
      ],
    );
  }
}
