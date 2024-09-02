import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';




class WebFilePickerController extends GetxController {
  var pickedFile = Rx<PlatformFile?>(null);
  var isUploading = false.obs;
  var uploadProgress = 0.0.obs;
  var downloadUrl = ''.obs;
  RxList pickFilesList = [].obs;
  RxList pickFilesNameList = [].obs;
  RxList downloadUrlList = [].obs;

  
  Future<void> pickFile() async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'tiff'],
  );

  if (result != null) {
    pickedFile.value = result.files.single;
    pickFilesList.add(result.files.single);
    pickFilesNameList.add(pickedFile.value!.name);
  }
}


  Future<void> uploadFile() async {
    if (pickedFile.value == null) return;

    for (var element in pickFilesList) {
    isUploading.value = true;
      
    try {
      final storageRef = FirebaseStorage.instance.ref().child('uploads/${element.name}');
      final uploadTask = storageRef.putData(element.bytes!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress.value = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });

      await uploadTask.whenComplete(() => null);
      final url = await storageRef.getDownloadURL();
      downloadUrl.value = url;
      downloadUrlList.add(url);
      isUploading.value = false;
    } catch (e) {
      isUploading.value = false;
      print("Error uploading file: $e");
    }
    }
  }
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(GetMaterialApp(
//     home: WebFilePickerUI(),
//   ));
// }
