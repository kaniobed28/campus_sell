import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickedItem extends StatelessWidget {
   const ClickedItem({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Get.arguments ?? {};

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${data["itemName"]?.toString() ?? "nothing"} Details'),
        ),
        body: Container(
          height: screenHeight * .5,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(GetMaterialApp(home:  ClickedItem()));
}