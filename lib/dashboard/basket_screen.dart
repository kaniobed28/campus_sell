import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// BasketScreen is a UI representation of the user's basket. It uses GetX for state management.
class BasketScreen extends StatelessWidget {
  // Instantiate the BasketController using GetX's dependency injection.
  final BasketController _basketController = Get.put(BasketController());
  final String userId; // User ID is passed to this screen to identify the user's basket.

  // Constructor that requires the userId parameter to be provided when the screen is created.
  BasketScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title of the screen
        title: const Text(
          'Your Basket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[400],
        elevation: 0,
      ),
      // StreamBuilder listens to the user's basket stream from the controller.
      body: StreamBuilder<List<BasketItemCount>>(
        stream: _basketController.getUserBasketWithCount(userId), // Retrieve user's basket data.
        builder: (context, snapshot) {
          // Display a loading indicator while the data is being fetched.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Display an error message if an error occurs during data retrieval.
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Display a message if the basket is empty.
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyBasket();
          }

          // If the data is successfully retrieved, calculate the total price of items in the basket.
          final basketItems = snapshot.data!;
          final totalPrice = basketItems.fold<double>(0, (sum, item) => sum + item.totalPrice);

          return Column(
            children: [
              // Display the list of items in the basket.
              Expanded(
                child: _buildBasketList(basketItems),
              ),
              // Display the checkout bar with the total price and checkout button.
              _buildCheckoutBar(totalPrice),
            ],
          );
        },
      ),
    );
  }

  // Widget to display when the basket is empty.
  Widget _buildEmptyBasket() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Your basket is empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start adding items to your basket.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Builds the list of items in the basket.
  Widget _buildBasketList(List<BasketItemCount> basketItems) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: basketItems.length,
      separatorBuilder: (context, index) => Divider(color: Colors.grey[300]), // Separator between items.
      itemBuilder: (context, index) {
        final item = basketItems[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
              child: Text(
                '${item.count}', // Display the count of the item in the basket.
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              item.itemName, // Display the name of the item.
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              // Display the quantity and price of the item.
              'Quantity: ${item.count}\nPrice: \$${item.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent), // Delete button to remove the item from the basket.
              onPressed: () {
                // Handle item removal logic here.
              },
            ),
            onTap: () {
              // Navigate to the item details page when the item is tapped.
              Get.toNamed("/shopitems/itemcode/${item.itemId}");
            },
          ),
        );
      },
    );
  }

  // Builds the checkout bar at the bottom of the screen, showing the total price and a checkout button.
  Widget _buildCheckoutBar(double totalPrice) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:  BoxDecoration(
        color: Colors.amber[400],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // Display the total price of all items in the basket.
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the checkout process here.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
