import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// A stateless widget that represents a button to add an item to the user's basket.
class AddToBasketButton extends StatelessWidget {
  final String itemId; // The ID of the item that will be added to the basket.
  final String userId; // The ID of the user who is adding the item to the basket.
  final RxBool isAuthenticated; // An observable boolean that tracks whether the user is authenticated.

  // Constructor to initialize the widget with the required parameters.
  const AddToBasketButton({
    super.key,
    required this.itemId,
    required this.isAuthenticated, 
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    // Fetching the BasketController instance using GetX dependency injection.
    BasketController basketController = Get.find<BasketController>();

    return FloatingActionButton(
      onPressed: () {
        // Check if the user is authenticated.
        if (!isAuthenticated.value) {
          // If not authenticated, show a snackbar prompting the user to log in.
          Get.snackbar("Log In First", "Tap on Home to move to the Login Screen");
        } else {
          // If authenticated, add the item to the basket.
          Get.snackbar("Added to Basket", "Item has been added to your basket.");
          basketController.addItemToBasket(userId, itemId); // Call to add item to the basket.
        }
      },
      backgroundColor: Colors.amber[400], // Set the button color.
      child: const Icon(Icons.add_shopping_cart), // Icon indicating the action of adding to the cart.
    );
  }
}
