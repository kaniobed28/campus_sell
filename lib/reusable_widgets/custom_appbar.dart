import 'package:flutter/material.dart';
import 'package:get/get.dart';

// This is where I made the custom app bar. We can use it or work on it separately so that any changes we make 
// can be focused on here without needing to go through the entire codebase.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height; // Height of the AppBar, defaulting to the standard toolbar height.
  final String? appBarTitle;

  // Constructor for CustomAppBar. The height parameter is optional, with a default value of kToolbarHeight.
  const CustomAppBar({super.key, this.height = kToolbarHeight, this.appBarTitle});

  // This defines the size of the AppBar, which is required by the PreferredSizeWidget interface.
  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Clips the AppBar with rounded corners at the bottom.
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        height: height, // Sets the height of the AppBar container.
        color: const Color(0xFFFBD300), // Custom background color for the AppBar.
        child: AppBar(
          title: Text(appBarTitle ?? ''),

          backgroundColor: Colors.transparent, // Makes the AppBar background transparent so that the container color is visible.
          elevation: 0, // Removes the default AppBar shadow.
          leading:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/");
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white, // Outer circle's background color.
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    // Inner circle image. Replace with an appropriate image for your app.
                    backgroundImage: AssetImage("assets/img/campus-sell-favicon-color.png"),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu), // Menu icon at the right side of the AppBar.
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Opens the end drawer when the menu icon is tapped.
              },
            ),
          ],
        ),
      ),
    );
  }
}
