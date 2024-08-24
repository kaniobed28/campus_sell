import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToBasketButton extends StatelessWidget {
  final String itemId;
  final RxBool isAuthenticated;

  const AddToBasketButton({
    super.key,
    required this.itemId,
    required this.isAuthenticated,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (!isAuthenticated.value) {
          Get.snackbar("LogIn First", "Tab on Home to move to the Login Screen");
        } else {
          Get.snackbar("Added to Basket", "Item has been added to your basket.");
          // Add your basket logic here
          // e.g., basketController.addItemToBasket(itemId);
        }
      },
      backgroundColor: Colors.amber[400],
      child: const Icon(Icons.add_shopping_cart),
    );
  }
}
