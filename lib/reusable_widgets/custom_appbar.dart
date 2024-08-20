import 'package:flutter/material.dart';
// this is  where I made the custom appbar. we can use it or work on it seperately so that any changes we dont have to read the whole code but only here
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({super.key, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        height: height,
        color: const Color(0xFFFBD300),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage:AssetImage("assets/img/campus-sell-favicon-color.png"), //NetworkImage('https://your-image-url.com/profile.jpg'),
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
          ],
        
        ),
      ),
    );
  }
}
