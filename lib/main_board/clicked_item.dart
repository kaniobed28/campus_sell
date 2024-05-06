import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          title: Text('${data["itemName"]?.toString() ?? "No "} Details'),
        ),
        body: Column(
          children: [
            Container(
              //container for item clicked images
              height: screenHeight * .4,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image(
                image: NetworkImage('${data['imagesUrls'][0].toString()}'), //Remember to let user flip around or do it by default.
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              //container for item clicked additional info
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                          'Item Name: ${data["itemName"]?.toString() ?? "Not Setted "} '),
                    ),
                    ListTile(
                      title: Text(
                          'Price: ${data["price"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'phone: ${data["phone"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'WhatsApp: ${data["whatsapp"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                    ListTile(
                      title: Text(
                          'University: ${data["university"]?.toString() ?? "Not Setted  "} '),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(GetMaterialApp(home: ClickedItem()));
}
