// screens/basket_screen.dart


import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:campus_sell/intermediaries/controllers/inmediaries_controller.dart';
import 'package:campus_sell/intermediaries/controllers/transaction_controller.dart';
import 'package:campus_sell/intermediaries/views/intermediary_reponse_listener.dart';
import 'package:campus_sell/intermediaries/views/manage_item_dialog.dart';
import 'package:campus_sell/reusable_widgets/custom_image_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketScreen extends StatelessWidget {
  final BasketController _basketController = Get.put(BasketController());
  final IntermediaryController _intermediaryController = Get.put(IntermediaryController());
  final TransactionController _transactionController = Get.put(TransactionController());

  final String userId;

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
      body: Stack(
        children: [
          StreamBuilder<List<BasketItemCount>>(
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
                  Expanded(
                    child: _buildBasketList(basketItems),
                  ),
                  _buildCheckoutBar(totalPrice),
                ],
              );
            },
          ),
          // Listener for intermediary responses
          Positioned.fill(
            child: IntermediaryResponseListener(
              userId: userId,
              itemId: '', // Adjust based on specific logic
            ),
          ),
        ],
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'Quantity: ${item.count}\nPrice: Gh¢${item.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.grey[600],
              ),
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ManageItemDialog(
                            userId: userId,
                            itemId: item.itemId,
                          );
                        },
                      );
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

  Widget _buildCheckoutBar(double totalPrice) {
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
            onPressed: () {
              // Placeholder for checkout functionality.
              Get.snackbar(
                'Checkout',
                'Checkout feature coming soon!',
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
}
