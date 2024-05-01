import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  RxList<XFile> images = <XFile>[].obs;
  List imagesUrls = <String>[]; // I have to change it to normal list if there is not need for it later.

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        images.add(image);
      }
    } catch (e) {
      // Handle errors (e.g., permission denied)
    }
  }

  Future<void> uploadImagesToFirebase() async {
    for (XFile image in images) {
      try {
        File file = File(image.path);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
         firebase_storage.Reference ref =  firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child(fileName);
        await ref.putFile(file);
        String imageUrl = await ref.getDownloadURL();
        // Download links of the seller item images has been added  to the list of images ulrs.
        imagesUrls.add(imageUrl);
        print(imagesUrls.toList());
        print('Image uploaded to Firebase: $imageUrl');
      } catch (e) {
        print('Error uploading image to Firebase: $e');
      }
    }
  }
}
