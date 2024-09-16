import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_navbar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final double? height;

  CustomBottomNavBar({this.height});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    // Retrieve current route
    String currentRoute = Get.currentRoute;

    return Container(
      height: height,
      color: const Color(0xFFFBD300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarItem(
            icon: Icons.location_on_outlined,
            label: 'Home',
            isSelected: currentRoute == '/', // Check if this item is selected
            onTap: () {
              Get.offNamed('/');
            },
          ),
          NavBarItem(
            icon: Icons.local_shipping_outlined,
            label: 'Add to my Shop',
            isSelected: currentRoute == '/shopitems/addtostore', // Check selection
            onTap: () async {
              await Get.offNamed('/shopitems/addtostore');
            },
          ),
          NavBarItem(
            icon: Icons.add_business_sharp,
            label: 'My Shop',
            isSelected: currentRoute.startsWith('/shop/shopitems'), // Check if selected
            onTap: () async {
              if (authController.isAuthenticated.isFalse) {
                await Get.offNamed('/shop/shopitems/not-authenticated');
              } else {
                await Get.offNamed('/shop/shopitems/${authController.uid.value}');
              }
            },
          ),
          NavBarItem(
            icon: Icons.add_shopping_cart,
            label: 'Basket',
            isSelected: currentRoute == '/basket', // Check if selected
            onTap: () async {
              await Get.to(BasketScreen(userId: authController.uid.value));
            },
          ),
        ],
      ),
    );
  }
}
