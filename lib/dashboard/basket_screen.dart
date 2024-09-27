// lib/screens/basket_screen.dart

import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:campus_sell/intermediaries/models/transaction_model.dart';
import 'package:campus_sell/intermediaries/views/select_intermediary_screen.dart';
import 'package:campus_sell/intermediaries/views/user_transaction_page.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketScreen extends StatelessWidget {
  final BasketController _basketController = Get.put(BasketController());
  final TransactionController _transactionController = Get.put(TransactionController());
  final AuthController authController = Get.put(AuthController());
  final String userId; // User ID to identify the user's basket

  BasketScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Basket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFBD300),
        elevation: 0,
      ),
      body: StreamBuilder<List<BasketItemCount>>(
        stream: _basketController.getUserBasketWithCount(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CustomImageLoader(imagePath: "assets/img/campus-sell-favicon-color.png"),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyBasket();
          }

          final basketItems = snapshot.data!;
          final totalPrice = basketItems.fold<double>(0, (sum, item) => sum + item.totalPrice);

          return Column(
            children: [
              Expanded(child: _buildBasketList(basketItems)),
              _buildCheckoutBar(totalPrice, basketItems), // Pass basketItems here
            ],
          );
        },
      ),
    );
  }

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

  Widget _buildBasketList(List<BasketItemCount> basketItems) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: basketItems.length,
      separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
      itemBuilder: (context, index) {
        final item = basketItems[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFBD300),
              child: Text(
                '${item.count}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              item.itemName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              'Quantity: ${item.count}\nPrice: Gh¢${item.price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      _basketController.removeItemFromBasket(item.documentId);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed("/item-management/${item.itemId}");
                    },
                    child: const Text(
                      'Manage Item',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Get.toNamed("/shopitems/itemcode/${item.itemId}");
            },
          ),
        );
      },
    );
  }

  Widget _buildCheckoutBar(double totalPrice, List<BasketItemCount> basketItems) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: Gh¢${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFFFBD300),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Ensure that basketItems is not empty
              if (basketItems.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Your basket is empty.',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
                return;
              }

              // Select an intermediary
              String intermediaryId = await _selectIntermediary();

              if (intermediaryId.isEmpty) {
                // User did not select an intermediary
                return;
              }

              // Create transaction
              await _transactionController.createTransaction(
                userId: userId,
                intermediaryId: intermediaryId,
                items: basketItems
                    .map((basketItem) => TransactionItem(
                          itemId: basketItem.itemId,
                          itemName: basketItem.itemName,
                          quantity: basketItem.count.toInt(),
                          price: basketItem.price,
                        ))
                    .toList(),
              );

              // Clear the basket after checkout
              await _basketController.clearBasket(userId);

              Get.snackbar(
                'Success',
                'Checkout completed! Waiting for intermediary approval.',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );

              // Navigate to User Transaction Page
              Get.to(UserTransactionPage(userId: authController.uid.value,));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color(0xFFFBD300),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _selectIntermediary() async {
    String selectedIntermediaryId = '';
    await Get.to(() => SelectIntermediaryScreen(
          userId: userId,
          onSelect: (intermediaryId) {
            selectedIntermediaryId = intermediaryId;
          },
        ));
    if (selectedIntermediaryId.isEmpty) {
      Get.snackbar('Error', 'No intermediary selected.');
    }
    return selectedIntermediaryId;
  }
}
