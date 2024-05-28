import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyPromotionController extends GetxController {


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
        title: 'Welcome To Campus Sell Promotion',
        content: const Text('We allow you to buy promotion time to advertise you items for a while.'),
        textCancel: 'Cancel',
        textConfirm: 'Buy Now',
        onCancel: () {
          // Handle cancel action
          Get.back();
        },
        onConfirm: () {
          // Handle confirm action
          Get.back();
          Get.snackbar(
      'Notification',
      'Sorry promotion not available now! Please check for update.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
        },
      );
    });
  }
}

class BuyPromotion extends StatelessWidget {
  final controller = Get.put(BuyPromotionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Promotion Time'),
      ),
      body: const Center(
        child: Text('App still under development and promotion will come soon'),
      ),
    );
  }
}
