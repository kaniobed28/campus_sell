import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Container(
                width: 80.0,
                height: 80.0,
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
          const Divider(color: Colors.grey),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _drawerItem(
                    context,
                    icon: Icons.home_outlined, // Changed to home icon
                    title: 'Home',
                    route: '/',
                    isSelected: Get.currentRoute == '/',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.person_outline, // Changed to person icon
                    title: 'My Profile',
                    route: '/shopitems/profile',
                    isSelected: Get.currentRoute == '/shopitems/profile',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.search_outlined, // Changed to search icon
                    title: 'Search Item',
                    route: '/shopitems/multisearch',
                    isSelected: Get.currentRoute == '/shopitems/multisearch',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.message_outlined, // Changed to chat icon
                    title: 'My Chats',
                    route: '/chats',
                    isSelected: Get.currentRoute == '/chats',
                  ),
                  _drawerItem(
                    context,
                    icon:
                        Icons.shopping_cart_outlined, // Changed to basket icon
                    title: 'My Basket',
                    route: '/shop/basket',
                    isSelected: Get.currentRoute == '/shop/basket',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons.follow_the_signs, //
                    title: 'Follows',
                    route: (widget.authController.isAuthenticated.isFalse)
                        ? '/shop/followedshops/not-authenticated'
                        : '/shop/followedshops/${widget.authController.uid.value}',
                    isSelected:
                        Get.currentRoute.contains('/shop/followedshops/'),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons
                        .business_outlined, // Changed to business/shop icon
                    title: 'My Shop',
                    route: (widget.authController.isAuthenticated.isFalse)
                        ? "/shop/shopitems/not-authenticated"
                        : "/shop/shopitems/${widget.authController.uid.value}",
                    isSelected: Get.currentRoute.contains('shop/shopitems/'),
                  ),
                  _drawerItem(
                    context,
                    icon: Icons
                        .store_mall_directory_outlined, // Changed to shop icon
                    title: 'Add to My Shop',
                    route: '/shopitems/addtostore',
                    isSelected: Get.currentRoute == '/shopitems/addtostore',
                  ),
                  _drawerItem(
                    context,
                    icon: Icons
                        .remove_shopping_cart_outlined, // Changed to remove shop icon
                    title: 'Remove from My Shop',
                    route: '/shopitems/removeitems',
                    isSelected: Get.currentRoute == '/shopitems/removeitems',
                  ),
                  Visibility(
                    visible:true,
                    child: _drawerItem(
                      context,
                      icon: Icons
                          .track_changes, // Changed to remove shop icon
                      title: 'trans',
                      route: '/transaction',
                      isSelected: Get.currentRoute == '/shopitems/removeitems',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sign In/Out button
          Column(
            children: [
              const Divider(color: Colors.grey),
              _drawerItem(
                context,
                icon: Icons.logout, // Sign out icon
                title: (widget.authController.isAuthenticated.isFalse)
                    ? "Sign In"
                    : 'Sign Out',
                onTap: () async {
                  await widget.authController.signOut();
                  await Get.offAllNamed('/auth/signin');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Drawer item widget with updated design
  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => Get.toNamed(route ?? ''),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250), // Animation duration
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 4.0), // Spacing
        padding: const EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 8.0), // Padding
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.amber.shade50
              : Colors.white, // Color change for selected item
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          border: Border.all(
            color: isSelected
                ? Colors.black26
                : Colors.transparent, // Border for selected item
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, // Shadow for a slight elevation effect
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon inside a circular container
            Container(
              padding: const EdgeInsets.all(6.0), // Padding for icon
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? Colors.amber.shade400
                    : Colors.grey.shade300, // Background color of icon
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black54, // Icon color
                size: 20.0, // Icon size
              ),
            ),
            const SizedBox(width: 12.0), // Space between icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main title
                  Text(
                    title,
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w500, // Font weight
                      fontSize: 14.0, // Font size
                      color: isSelected
                          ? Colors.amber.shade700
                          : Colors.black87, // Text color
                    ),
                  ),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        'Selected',
                        style: TextStyle(
                          fontSize: 10.0, // Subtitle font size
                          color: Colors.amber.shade600, // Subtitle color
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Checkmark for selected item
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Icon(
                Icons.check_circle,
                color: Colors.amber.shade600,
                size: 18.0, // Checkmark icon size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
