import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:campus_sell/dashboard/custom_product_card.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryAllProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> productList;
  final String categoryLabel;
  final bool? showAppBar;

  const CategoryAllProductsPage({
    super.key,
    required this.productList,
    required this.categoryLabel,
    this.showAppBar = true, // Default is true, meaning AppBar will show
  });

  @override
  Widget build(BuildContext context) {
    ViewController viewController = Get.find<ViewController>();
    AuthController authController = Get.find<AuthController>();
    BasketController basketController = Get.find<BasketController>();

    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerWidget(authController: authController),
        drawer: DrawerWidget(authController: authController),

        // Conditionally show AppBar based on showAppBar value
        appBar: showAppBar == true 
            ? CustomAppBar(
                appBarTitle: categoryLabel,
              )
            : null,

        body: productList.isEmpty
            ? const Center(
                child: Text('No products available in this category'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final data = productList[index];

                  return Dismissible(
                    key: Key(data['id'].toString()), // Unique key for each item
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.teal,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(Icons.add_shopping_cart,
                          color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      // Perform the action without removing the item
                      if (direction == DismissDirection.endToStart) {
                        if (!authController.isAuthenticated.isTrue) {
                          // If not authenticated, show a snackbar prompting the user to log in.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Login is required for this action')),
                          );
                        } else {
                          // If authenticated, add the item to the basket.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Added to basket successfully.')),
                          );

                          basketController.addItemToBasket(
                              authController.uid.value,
                              data["id"]); // Call to add item to the basket.
                        }
                      } else if (direction == DismissDirection.startToEnd) {
                        // Handle delete action (optional)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Deleted')),
                        );
                      }
                      // Optionally reset the item's position
                      // You can implement custom logic to update UI if needed
                    },
                    child: ProductCard(
                      imageUrl: data["imagesUrls"][0],
                      itemName: data["itemName"].toString().trim(),
                      price: 'Gh¢${data["price"].toString().trim()}',
                      likes: data["likes"].length,
                      onTap: () async {
                        if (data['id'] != null) {
                          await Get.toNamed(
                              "/shopitems/itemcode/${data['id']}");
                          await viewController
                              .markItemAsViewedByUser(data['id']);
                          await viewController.markItemAsViewed(
                              data['id'], data['ownerId']);
                        } else {
                          // Handle the case when 'id' is null
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
