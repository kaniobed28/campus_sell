import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/reusable_widgets/item_editable_widgets.dart';
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

  const AgoTechProductDetailsCard(
      {super.key,
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
      required this.itemId});

  @override
  Widget build(BuildContext context) {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController itemPriceController = TextEditingController();
    TextEditingController itemDescriptionController = TextEditingController();
    RegExp itemNameRegExp = RegExp(r'^[a-zA-Z0-9\s]+$');
RegExp itemPriceRegExp = RegExp(r'^\d+(\.\d+)?$');
    RegExp itemDescriptionRegExp =
        RegExp(r'^[\p{L}\p{N}\p{P}\p{S}\s]+$', unicode: true);

    IsOwnerController isOwnerController = Get.find<IsOwnerController>();
    AuthController authController = Get.find<AuthController>();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // I will be checking if owner here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Wrap the Text widget with Expanded
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow:
                        TextOverflow.visible, // Ensure text is not clipped
                    softWrap: true, // Enable wrapping to the next line
                  ),
                ),
                Visibility(
                  visible: isOwnerController.isOwner,
                  child: IconButton(
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
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Wrap the Text widget with Expanded
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow
                        .visible, // This ensures text is not clipped
                    softWrap: true, // This enables wrapping to the next line
                  ),
                ),
                Visibility(
                  visible: isOwnerController.isOwner,
                  child: IconButton(
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
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.add_business_sharp, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text(
                  brandName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
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
                Visibility(
                  visible: isOwnerController.isOwner,
                  child: IconButton(
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
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(Icons.phone, color: Colors.grey[600]),
                const SizedBox(width: 5.0),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle "More Details" action here
                  Get.defaultDialog(
                      title: "More Details",
                      content: Column(
                        children: <Widget>[
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item Name: $title",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: title.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            title.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Owner's Shop: $brandName",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: brandName.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            brandName.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price: Gh¢ $price",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: price.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            price.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Phone: $phone",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: phone.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            phone.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("City: $city"),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: city.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            city.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Hostel/Address: $hostel",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: hostel.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            hostel.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "University: $university",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: university.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            university.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Category: $itemType",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: itemType.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            itemType.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          FittedBox(
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Social Media: $socialMedia",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: socialMedia.toString()));
                                        Get.snackbar("Copied to Cliipboard",
                                            socialMedia.toString(),
                                            duration: const Duration(
                                                seconds: 1, milliseconds: 500));
                                      },
                                      child: const Icon(Icons.copy_sharp))
                                ],
                              ),
                            ),
                          ),
                          // Text("Owner's Brand: $brandName"),
                          // Text("Price: $price"),
                          // Text("Phone: $phone"),
                          // Text("City: $city"),
                          // Text("Address/Hostel: $hostel"),
                          // Text("University: $university"),
                          // Text("Item Category: $itemType"),
                          // Text("Social Media Contact: $socialMedia"),
                        ],
                      ));
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
