import 'package:flutter/material.dart';

import 'custom_navbar_item.dart';

// the height of this is controllerable and  I am using 70 for testing purpose
class CustomBottomNavBar extends StatelessWidget {
  final double height;

  CustomBottomNavBar({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: const Color(0xFFFBD300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              // Handle Home tap
            },
          ),
          NavBarItem(
            icon: Icons.attach_money,
            label: 'Sell Item',
            onTap: () {
              // Handle Sell Item tap
            },
          ),
          NavBarItem(
            icon: Icons.category,
            label: 'Categories',
            onTap: () {
              // Handle Categories tap
            },
          ),
        ],
      ),
    );
  }
}
