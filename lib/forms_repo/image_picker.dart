import 'dart:io';
import 'package:campus_sell/controllers/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerPage extends StatelessWidget {

  final ImageController imageController = Get.put(ImageController());
  // final ImageController imageController = Get.find<ImageController>();
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => imageController.images.isEmpty
                  ?const Text('No images selected.')
                  : Column(
                      children: imageController.images
                          .map(
                            (image) => Image.file(
                              File(image.path),
                              height: 200,
                            ),
                          )
                          .toList(),
                    ),
            ),
           const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async { await imageController.pickImage(ImageSource.camera);},
              child: Text('Take Picture',style: GoogleFonts.average(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () async=>
                  await imageController.pickImage(ImageSource.gallery),
              child: Text('Choose from Gallery',style: GoogleFonts.average(color: Colors.black),),
            ),
            
          ],
        ),
      ),
    );
  }
}

