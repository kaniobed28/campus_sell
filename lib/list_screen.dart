import 'package:campus_sell/controllers/device_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for QuerySnapshot
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/delete_controller.dart';

class ListScreen extends StatelessWidget {
  final DeleteController deleteController = Get.put(DeleteController());
  final RxString shopName = "".obs;
  final AuthController authController = Get.find<AuthController>();
  final DeviceController deviceController = Get.find<DeviceController>();

  ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? shopId = Get.parameters["id"];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.black),
          onPressed: () {
            Get.offAllNamed('/'); // Navigate to home and clear the stack
          },
        ),
        title: Obx(
          () => Text(
            shopName.value,
            style: GoogleFonts.aclonica(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFBD300),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              String shopUrl = "https://campussell.github.io/#/shop/shopitems/$shopId";
              Share.share('Check out this shop: $shopUrl');
            },
          ),
        ],
      ),
      bottomNavigationBar: Visibility(
        visible: !deviceController.isWeb.value,
        child: CustomBottomNavBar(height: 50),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: deleteController.listForShopItems(shopId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyList();
          }

          final items = snapshot.data!.docs;
          return ListView.separated(
            padding: const EdgeInsets.all(8.0),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              Map<String, dynamic> data = items[index].data();
              String id = items[index].id;

              String description = data["description"] ?? "Check out this item!";
              String url = "https://campussell.github.io/#/shopitems/itemcode/$id";
              String contentToShare = "$description\n\n$url";
              
              // Call this after the tree has finished building
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (data["ownerId"] != authController.uid.value) {
                  shopName.value = data["brand"];
                } else {
                  shopName.value = "My Shop";
                }
              });

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey[200],
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  title: Text(
                    data["itemName"],
                    style: GoogleFonts.average(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "GH¢ ${data["price"].toString()}",
                    style: GoogleFonts.average(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.share, color: Colors.blue),
                    onPressed: () {
                      Share.share(contentToShare);
                    },
                  ),
                  onTap: () {
                    Get.toNamed('/shopitems/itemcode/$id');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'No items available',
            style: GoogleFonts.average(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'There are no items in this shop.',
            style: GoogleFonts.average(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
