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
              Get.offNamed('/');
            },
          ),
          NavBarItem(
            icon: Icons.local_shipping_outlined,
            label: 'Add to my Shop',
            onTap: () async {
              await Get.offNamed('/shopitems/addtostore');
              // Handle Sell Item tap
            },
          ),
          NavBarItem(
            icon: Icons.add_business_sharp,
            label: 'My Shop',
            onTap: () async{
             await Get.offNamed('/shopitems/myitems');
              // Handle Categories tap
            },
          ),
        ],
      ),
    );
  }
}
