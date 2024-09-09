import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class DeviceController extends GetxController {
  RxBool isMobile = false.obs;
  RxBool isTablet = false.obs;
  RxBool isWeb = false.obs;
  RxBool isAndroid = false.obs;
  RxBool isIOS = false.obs;
  RxBool isWindows = false.obs;
  RxBool isMacOS = false.obs;
  RxBool isLinux = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkDeviceType();
    checkOS();
  }

  void checkDeviceType() {
    if (kIsWeb) {
      isWeb.value = true;
    } else {
      // Check for mobile or tablet
      if (Get.context != null) {
        var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
        if (shortestSide < 600) {
          isMobile.value = true;
        } else {
          isTablet.value = true;
        }
      }
    }
  }

  void checkOS() {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        isAndroid.value = true;
      } else if (Platform.isIOS) {
        isIOS.value = true;
      } else if (Platform.isWindows) {
        isWindows.value = true;
      } else if (Platform.isMacOS) {
        isMacOS.value = true;
      } else if (Platform.isLinux) {
        isLinux.value = true;
      }
    }
  }
}
