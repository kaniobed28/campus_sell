import 'dart:convert'; // Import this for Base64 encoding
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http; // Import for HTTP requests
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart'; // Import for XFile

class ShareController extends GetxController {
  Future<void> shareWithImage(String imageUrl, String contentToShare) async {
    try {
      if (kIsWeb) {
        // Use Base64 for web
        String base64Image = await fetchImageAsBase64(imageUrl);
        final dataUrl = 'data:image/jpeg;base64,$base64Image';
        
        // Share the data URL directly
        await Share.shareXFiles([XFile(dataUrl)], text: contentToShare);
      } else {
        // Use file for mobile
        String localImagePath = await downloadImage(imageUrl);
        List<XFile> files = [XFile(localImagePath)];
        
        // Share the image file
        await Share.shareXFiles(files, text: contentToShare);
      }
    } catch (e) {
      print('Error sharing image: $e');
      // Handle error appropriately, maybe show a Snackbar or alert
    }
  }

  Future<String> downloadImage(String imageUrl) async {
    final Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
    final String filePath = '${(await getTemporaryDirectory()).path}/image.jpg';

    await ref.writeToFile(File(filePath));

    return filePath;
  }

  Future<String> fetchImageAsBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return base64Encode(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }
}
