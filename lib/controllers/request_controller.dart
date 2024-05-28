import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  @override
  void onInit() async{
    await _requestPermissions();
    super.onInit();
  }

  Future<void> _requestPermissions() async {
    // Request camera permission
    if (await Permission.camera.request().isGranted) {
      // The permission is granted, do something with the camera
    } else {
      // Handle the situation when the permission is not granted
    }

    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      // The permission is granted, do something with storage
    } else {
      // Handle the situation when the permission is not granted
    }
  }
}
