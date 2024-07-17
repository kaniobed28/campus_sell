import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_sell_screen.dart';
import 'package:campus_sell/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_navbar_item.dart';

// the height of this is controllerable and  I am using 70 for testing purpose
class CustomBottomNavBar extends StatelessWidget {

  final double? height;

  CustomBottomNavBar({ this.height});

  @override
  Widget build(BuildContext context) {
    //  PagesStateController pageStateController = Get.find<PagesStateController>();
    return Container(
      height: height,
      color: const Color(0xFFFBD300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarItem(
            icon: Icons.location_on_outlined,
            label: 'Home',
            onTap: () {
              // Handle Home tap
              Get.off(const NewDashboard());
            },
          ),
          NavBarItem(
            icon: Icons.sell_outlined,
            label: 'Sell Item',
            onTap: () {
              Get.off(const AgoTechSellScreen());
              // Handle Sell Item tap
            },
          ),
          NavBarItem(
            icon: Icons.tv,
            label: 'My Shop',
            onTap: () {
              Get.off( const ListScreen());
              // Handle Categories tap
            },
          ),
        ],
      ),
    );
  }
}
