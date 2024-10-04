import 'package:campus_sell/main_board/custom_appbar/controllers/custom_appbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? appBarTitle;
  double? elevation = 0;

  // Instantiate the ThemeController
  final ThemeController themeController = Get.find<ThemeController>();

  CustomAppBar({super.key, this.height = kToolbarHeight, this.appBarTitle, this.elevation});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Material(
        elevation: elevation!,
        child: Container(
          height: height,
          color: Theme.of(context).primaryColor,
          child: AppBar(
            title: Text(appBarTitle ?? '',style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed("/");
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/img/campus-sell-favicon-color.png"),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
              Obx(() => IconButton(
                icon: Icon(themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  themeController.toggleTheme();
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
