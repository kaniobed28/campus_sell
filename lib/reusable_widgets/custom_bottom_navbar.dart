import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_sell_screen.dart';
import 'package:campus_sell/dashboard/controllers/page_state_controller.dart';
import 'package:campus_sell/dashboard/main.dart';
import 'package:campus_sell/forms_repo/sell_page.dart';
import 'package:campus_sell/web_sell_screen.dart';
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
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              // Handle Home tap
              Get.off(const NewDashboard());
            },
          ),
          NavBarItem(
            icon: Icons.attach_money,
            label: 'Sell Item',
            onTap: () {
              Get.off(const AgoTechSellScreen());
              // Handle Sell Item tap
            },
          ),
          NavBarItem(
            icon: Icons.category,
            label: 'Categories',
            onTap: () {
              Get.off( WebFilePickerUI());
              // Handle Categories tap
            },
          ),
        ],
      ),
    );
  }
}
