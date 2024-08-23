import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/reusable_widgets/item_editable_widgets.dart';
import 'package:campus_sell/reusable_widgets/more_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AgoTechProductDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String brandName;
  final String phone;
  final String city;
  final String hostel; // hostel is the same as address. its hostel or address
  final String university;
  final String itemType;
  final String socialMedia;
  final String ownerId;
  final String itemId;

  const AgoTechProductDetailsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.brandName,
    required this.phone,
    required this.city,
    required this.hostel,
    required this.university,
    required this.itemType,
    required this.socialMedia,
    required this.ownerId,
    required this.itemId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController itemNameController = TextEditingController();
    final TextEditingController itemPriceController = TextEditingController();
    final TextEditingController itemDescriptionController = TextEditingController();
    final RegExp itemNameRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');
    final RegExp itemPriceRegExp = RegExp(r'^\d+(\.\d+)?$');
    final RegExp itemDescriptionRegExp = RegExp(r'^[\p{L}\p{N}\p{P}\p{S}\s]+$', unicode: true);

    final IsOwnerController isOwnerController = Get.find<IsOwnerController>();
    final AuthController authController = Get.find<AuthController>();
    isOwnerController.isShopItemOwner(authController.uid.value, ownerId);

    return Card(
      color: const Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title and Edit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isOwnerController.isOwner)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Edit Name",
                        content: ItemEditForm(
                          itemId: itemId,
                          textController: itemNameController,
                          validationPattern: itemNameRegExp,
                          fieldName: 'itemName',
                        ),
                        textCancel: "Cancel",
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 5.0),
            
            // Description and Edit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isOwnerController.isOwner)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Edit Description",
                        content: ItemEditForm(
                          itemId: itemId,
                          textController: itemDescriptionController,
                          validationPattern: itemDescriptionRegExp,
                          fieldName: 'description',
                        ),
                        textCancel: "Cancel",
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10.0),
            
            // Brand Name
            Row(
              children: <Widget>[
                Icon(Icons.add_business_sharp, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    brandName,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            
            // Price and Edit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Icon(Icons.sell, color: Colors.grey[600]),
                    const SizedBox(width: 5.0),
                    Text(
                      "Gh¢ $price",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                if (isOwnerController.isOwner)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Edit Price",
                        content: ItemEditForm(
                          itemId: itemId,
                          textController: itemPriceController,
                          validationPattern: itemPriceRegExp,
                          fieldName: 'price',
                        ),
                        textCancel: "Cancel",
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10.0),
            
            // Phone Number
            Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Text(
                    phone,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            
            // More Details Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "More Details",
                    content: SizedBox(
                      width: screenWidth,
                      height: 500,
                      child: MoreDetailsDialog(
                        title: title,
                        brandName: brandName,
                        price: price,
                        phone: phone,
                        city: city,
                        hostel: hostel,
                        university: university,
                        itemType: itemType,
                        socialMedia: socialMedia,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'More Details',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
