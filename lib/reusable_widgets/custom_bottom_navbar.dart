import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/basket_screen.dart';
import 'package:campus_sell/intermediaries/views/intermediary_registration_screen.dart';
import 'package:campus_sell/intermediaries/views/intermediary_transaction_page.dart';
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
            isSelected: currentRoute == '/'||currentRoute == '/shop'||currentRoute == '/shopitems', // Check if this item is selected
            onTap: () {
              Get.offNamed('/');
            },
          ),
          NavBarItem(
            icon: Icons.chat_sharp,
            label: 'Chats',
            isSelected: currentRoute == '/chats', // Check selection
            onTap: () async {
              await Get.offNamed('/chats');
            },
          ),
          NavBarItem(
            icon: Icons.add_business_sharp,
            label: 'register',
            isSelected: currentRoute.startsWith('/shop/shopitems'), // Check if selected
            onTap: () async {
              Get.to(AddIntermediaryScreen());
            },
          ),
          NavBarItem(
            icon: Icons.add_business_sharp,
            label: 'dashbaord',
            isSelected: currentRoute.startsWith('/shop/shopitems'), // Check if selected
            onTap: () async {
              Get.to(IntermediaryTransactionPage(intermediaryId: 'OP1JU5p1oFGuiMTKd42Y',));
            },
          ),
          
          Visibility(
            visible: true,
            child: NavBarItem(
              icon: Icons.follow_the_signs,
              label: 'Follows',
              isSelected: currentRoute == '/follows', // Check if selected
              onTap: () async {
                await Get.toNamed((authController.isAuthenticated.isFalse)?'/shop/followedshops/not-authenticated':'/shop/followedshops/${authController.uid.value}');
              },
            ),
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
