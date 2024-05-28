import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageController extends GetxController {
  RxList<XFile> images = <XFile>[].obs;
  List<String> imagesUrls = <String>[];

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        images.add(image);
      }
    } catch (e) {
      // Handle errors (e.g., permission denied)
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImagesToFirebase() async {
    for (XFile image in images) {
      try {
        // Compress the image
        XFile? compressedImage = await compressImage(image);

        if (compressedImage != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child(fileName);
          await ref.putFile(File(compressedImage.path));
          String imageUrl = await ref.getDownloadURL();
          imagesUrls.add(imageUrl);
          print('Image uploaded to Firebase: $imageUrl');
        }
      } catch (e) {
        print('Error uploading image to Firebase: $e');
      }
    }

    // If no image uploaded, add a placeholder URL before clearing the list
    if (imagesUrls.isEmpty) {
      imagesUrls.add('https://example.com/placeholder.jpg');
    }

    clearImages(); // Call the method to clear the images list
  }

  Future<XFile?> compressImage(XFile file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(dir.absolute.path, 'temp_${DateTime.now().millisecondsSinceEpoch}.jpg');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 20, // Adjust quality as needed.
    );

    return result != null ? XFile(result.path) : null;
  }

  void clearImages() {
    images.clear();
  }
}
