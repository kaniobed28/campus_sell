import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/list_screen.dart';
import 'package:campus_sell/main_board/buy_promotion.dart';
import 'package:campus_sell/main_board/delete_page.dart';
import 'package:campus_sell/search/views/search_screen.dart';
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
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
              child: Container(
                width: 120.0, // Adjust width as needed
                height: 120.0, // Adjust height as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.amber,
                    width: 2.0, // Adjust border width as needed
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/img/campus-sell-favicon-color.png",
                    width: 100.0, // Adjust width as needed
                    height: 100.0, // Adjust height as needed
                    fit: BoxFit
                        .cover, // Ensures the image fits within the given dimensions
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(
              'Additional Info',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.to(() => SellInfoScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text(
              'Search Item',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.to(() => SearchScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.sell),
            title: Text(
              'Sell Item',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.to(() => SellPage()),
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: Text(
              'Remove Item',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.to(() => const DeleteScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: Text(
              'My Items',
              style: GoogleFonts.average(),
            ),
            onTap: () {
              //
              Get.to(() => ListScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.outbond),
            title: Text(
              'SignOut',
              style: GoogleFonts.average(),
            ),
            onTap: () {
              // AuthController authController = Get.find<AuthController>();
              // AuthController authController = Get.put(AuthController());
              authController.signOut();
              // authController.dispose();
              Get.offAll(() => SignIn());
            },
          ),
        ],
      ),
    );
  }
}