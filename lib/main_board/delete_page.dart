import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/delete_controller.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    DeleteController deleteController = Get.put(DeleteController());

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: DrawerWidget(
        authController: authController,
      ),
      body: StreamBuilder(
        stream: deleteController.listForShopItems(authController.uid.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png"),);
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
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey[300]),
            itemBuilder: (context, index) {
              Map<String, dynamic> data = items[index].data();
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.deepOrangeAccent,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    data["itemName"],
                    style: GoogleFonts.average(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    data["itemType"],
                    style: GoogleFonts.average(color: Colors.grey[700]),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "GH¢ ${data["price"].toString()}",
                        style: GoogleFonts.average(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Confirm Delete",
                              middleText:
                                  "Are you sure you want to delete this item?",
                              textConfirm: "Yes",
                              textCancel: "No",
                              confirmTextColor: Colors.white,
                              onCancel: () {
                                Get.back();
                              },
                              onConfirm: () {
                                items[index].reference.delete();
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_forever,
              size: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'No items to delete',
              textAlign: TextAlign.center,
              style: GoogleFonts.average(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your item list is empty.',
              textAlign: TextAlign.center,
              style: GoogleFonts.average(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
