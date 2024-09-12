import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/img/campus-sell-favicon-color.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Column(
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.location_on_outlined,
                    title: 'Home',
                    route: '/',
                    isSelected: Get.currentRoute == '/',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.account_circle,
                    title: 'My Profile',
                    route: '/shopitems/profile',
                    isSelected: Get.currentRoute == '/shopitems/profile',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.search,
                    title: 'Search Item',
                    route: '/shopitems/multisearch',
                    isSelected: Get.currentRoute == '/shopitems/multisearch',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.local_shipping_outlined,
                    title: 'Add to My Shop',
                    route: '/shopitems/addtostore',
                    isSelected: Get.currentRoute == '/shopitems/addtostore',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.delete_sweep,
                    title: 'Remove from My Shop',
                    route: '/shopitems/removeitems',
                    isSelected: Get.currentRoute == '/shopitems/removeitems',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.add_business_sharp,
                    title: 'My Shop',
                    route: (authController.isAuthenticated.isFalse)?"/shop/shopitems/not-authenticated":"/shop/shopitems/${authController.uid.value}",//
                    isSelected: Get.currentRoute.contains('shop/shopitems/'),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.add_shopping_cart,
                    title: 'My Basket',
                    route: '/shop/basket',
                    isSelected: Get.currentRoute == '/shop/basket',
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Divider(),
              _drawerItem(
                context,
                icon: Icons.outbond,
                title:(authController.isAuthenticated.isFalse)?"Sign In": 'Sign Out',
                onTap: () async {
                  await authController.signOut();
                  await Get.offAllNamed('/auth/signin');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required IconData icon,
      required String title,
      String? route,
      VoidCallback? onTap,
      bool isSelected = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isSelected ? Colors.amber.shade50 : Colors.transparent,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.amber : Colors.black,
        ),
        title: Text(
          title,
          style: GoogleFonts.average(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.amber.shade700 : Colors.black87,
          ),
        ),
        onTap: onTap ?? () => Get.toNamed(route ?? ''),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.amber)
            : null,
      ),
    );
  }
}
