import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickedItem extends StatelessWidget {
  const ClickedItem({Key? key});

  @override
  Widget build(BuildContext context) {
    AdditionalInfoController additionalInfoController =
        Get.find<AdditionalInfoController>();
    Map<String, dynamic> data = Get.arguments ?? {};
    Future<Map<String, dynamic>?> ownerInfo =
        additionalInfoController.getDocumentById(data["ownerId"]);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${data["itemName"]?.toString() ?? "No "} Details'),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
           Container(
  height: screenHeight * 0.5,
  width: screenWidth,
  decoration: BoxDecoration(
    color: Colors.black54,
    borderRadius: BorderRadius.circular(20),
  ),
  child: PageView.builder(
    itemCount: data['imagesUrls'].length,
    itemBuilder: (context, index) {
      return Image.network(
        '${data['imagesUrls'][index].toString()}',
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const CircularProgressIndicator();
        },
      );
    },
  ),
),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Item Name: ${data["itemName"]?.toString() ?? "Not Set"}',
                      ),
                    ),FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'Brand: ${snapshot.data?["brand"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                   
                    // Add more ListTile widgets for other data fields
  }),
                    ListTile(
                      title: Text(
                        'Price: ${data["price"]?.toString() ?? "Not Set"}',
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'Phone: ${snapshot.data?["phone"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                      },
                    ),FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'Social Media: ${snapshot.data?["socialMedia"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                   
                    // Add more ListTile widgets for other data fields
  }),FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'City: ${snapshot.data?["city"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                   
                    // Add more ListTile widgets for other data fields
  }),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'University: ${snapshot.data?["university"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                   
                    // Add more ListTile widgets for other data fields
  }),FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'Hostel: ${snapshot.data?["hostel"]?.toString() ?? "Not Set"}',
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information'),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...'),
                        );
                   
                    // Add more ListTile widgets for other data fields
  }),],
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