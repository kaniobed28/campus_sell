import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/delete_controller.dart';



class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteController deleteController = Get.put(DeleteController());
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title:  Text('Delete your Items',style: GoogleFonts.aclonica(color: Colors.black),),
        backgroundColor: Colors.transparent,
        ),
      body: StreamBuilder(
        stream: deleteController.listForDelete(authController.uid.value),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return ListTile(
                  title: Text(data["itemName"],style: GoogleFonts.average(color: Colors.black),),
                  subtitle: Text(data["itemType"],style: GoogleFonts.average(color: Colors.black),),
                  trailing: FittedBox(
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Confirm Delete",
                              middleText: "Are you sure you want to delete?",
                              textConfirm: "Yes",
                              textCancel: "No",
                              confirmTextColor: Colors.white,
                              onCancel: () {
                                Get.back(); 
                              },
                              onConfirm: () {
                                snapshot.data!.docs[index].reference.delete();
                                Get.back();
                              },
                            );
                          },
                        ),
                        Text("GH¢ ${data["price"].toString()}",style: GoogleFonts.average(color: Colors.black),),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
