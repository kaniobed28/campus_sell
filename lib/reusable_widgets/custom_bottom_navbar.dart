import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/basket_screen.dart';
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
      color: Theme.of(context).primaryColor, // Using primary color from the theme
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarItem(
            icon: Icons.location_on_outlined,
            label: 'Home',
            isSelected: currentRoute == '/' || currentRoute == '/shop' || currentRoute == '/shopitems',
            onTap: () {
              Get.offNamed('/');
            },
          ),
          NavBarItem(
            icon: Icons.chat_sharp,
            label: 'Chats',
            isSelected: currentRoute == '/chats',
            onTap: () async {
              await Get.offNamed('/chats');
            },
          ),
          // Visibility(
          //   visible: true,
          //   child: NavBarItem(
          //     icon: Icons.add_business_sharp,
          //     label: 'Dashboard',
          //     isSelected: currentRoute.startsWith('/shop/shopitems'),
          //     onTap: () async {
          //       Get.to(IntermediaryTransactionPage(intermediaryId: 'OP1JU5p1oFGuiMTKd42Y'));
          //     },
          //   ),
          // ),
          Visibility(
            visible: true,
            child: NavBarItem(
              icon: Icons.follow_the_signs,
              label: 'Follows',
              isSelected: currentRoute == '/follows',
              onTap: () async {
                await Get.toNamed((authController.isAuthenticated.isFalse)
                    ? '/shop/followedshops/not-authenticated'
                    : '/shop/followedshops/${authController.uid.value}');
              },
            ),
          ),
          NavBarItem(
            icon: Icons.add_shopping_cart,
            label: 'Basket',
            isSelected: currentRoute == '/basket',
            onTap: () async {
              await Get.to(BasketScreen(userId: authController.uid.value));
            },
          ),
        ],
      ),
    );
  }
}
