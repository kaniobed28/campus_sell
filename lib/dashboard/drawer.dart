import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/mediator_registration_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.authController,
  });

  final AuthController authController;
//I have putted different things in the drawer to different columns so that the signout can be moved down.
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
           
          Column(
            children: [
          
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text(
              'My Profile',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.toNamed('shopitems/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text(
              'Search Item',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.toNamed('/shopitems/multisearch'),
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping_outlined),
            title: Text(
              'Add to My Shop',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.toNamed('/shopitems/addtostore'),
            //I have not changed 
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: Text(
              'Remove from My Shop',
              style: GoogleFonts.average(),
            ),
            onTap: () => Get.toNamed('/shopitems/removeitems'),
          ),
          ListTile(
            leading: const Icon(Icons.add_business_sharp),
            title: Text(
              'My Shop',
              style: GoogleFonts.average(),
            ),
            onTap: () {
              //
              Get.toNamed("/shop/shopitems/${authController.uid.value}");
            },
          ),
          Visibility(
            visible: false, 
            // I am putting visible here because I am still working on it
            child: ListTile(
              leading: const Icon(Icons.add_business_sharp),
              title: Text(
                'Register a mediator',
                style: GoogleFonts.average(),
              ),
              onTap: () {
                //
                Get.to(const RegisterMediatorScreen());
              },
            ),
          ),
            ],),
             ],
          ),
          Column(
            children: [
              const Divider(),
              ListTile(
                leading: const Icon(Icons.outbond),
                title: Text(
                  'SignOut',
                  style: GoogleFonts.average(),
                ),
                onTap: ()async {
                  // AuthController authController = Get.find<AuthController>();
                  // AuthController authController = Get.put(AuthController());
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
}