import 'dart:io';
import 'package:campus_sell/controllers/image_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';


class ImagePickerPage extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());

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
              onPressed: () => imageController.pickImage(ImageSource.camera),
              child:const Text('Take Picture'),
            ),
            ElevatedButton(
              onPressed: () =>
                  imageController.pickImage(ImageSource.gallery),
              child: Text('Choose from Gallery'),
            ),
            
          ],
        ),
      ),
    );
  }
}

