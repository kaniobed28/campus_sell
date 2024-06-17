import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/web_sell_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class WebFilePickerController extends GetxController {
  var pickedFile = Rx<PlatformFile?>(null);
  var isUploading = false.obs;
  var uploadProgress = 0.0.obs;
  var downloadUrl = ''.obs;

  Future<void> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'tiff'],
  );

  if (result != null) {
    pickedFile.value = result.files.single;
  }
}


  Future<void> uploadFile() async {
    if (pickedFile.value == null) return;

    isUploading.value = true;
    try {
      final storageRef = FirebaseStorage.instance.ref().child('uploads/${pickedFile.value!.name}');
      final uploadTask = storageRef.putData(pickedFile.value!.bytes!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress.value = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });

      await uploadTask.whenComplete(() => null);
      final url = await storageRef.getDownloadURL();
      downloadUrl.value = url;
      isUploading.value = false;
    } catch (e) {
      isUploading.value = false;
      print("Error uploading file: $e");
    }
  }
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(GetMaterialApp(
    home: WebFilePickerUI(),
  ));
}
