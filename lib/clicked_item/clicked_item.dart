import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ClickedItem extends StatelessWidget {
  const ClickedItem({Key? key});

  @override
  Widget build(BuildContext context) {
    AdditionalInfoController additionalInfoController =
        Get.put(AdditionalInfoController());
    Map<String, dynamic> data = Get.arguments ?? {};
    Future<Map<String, dynamic>?> ownerInfo =
        additionalInfoController.getDocumentById(data["ownerId"]);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${data["itemName"]?.toString() ?? "No "} Details',style: GoogleFonts.average(fontWeight: FontWeight.w700),),
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
                  return CachedNetworkImage(
                    imageUrl: data['imagesUrls'][index].toString(),
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                        'Item Name: ${data["itemName"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                        future: ownerInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(
                                'Owner"s Brand: ${snapshot.data?["brand"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                            );
                          }
                          return ListTile(
                            title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                          );

                          // Add more ListTile widgets for other data fields
                        }),
                    ListTile(
                      title: Text(
                        'Price: GHS ${data["price"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: ownerInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            title: Text(
                              'Phone: ${snapshot.data?["phone"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return ListTile(
                            title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                          );
                        }
                        return ListTile(
                          title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                        );
                      },
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                        future: ownerInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(
                                'Social Media: ${snapshot.data?["socialMedia"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                            );
                          }
                          return ListTile(
                            title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                          );

                          // Add more ListTile widgets for other data fields
                        }),
                    FutureBuilder<Map<String, dynamic>?>(
                        future: ownerInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(
                                'City: ${snapshot.data?["city"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                            );
                          }
                          return ListTile(
                            title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                          );

                          // Add more ListTile widgets for other data fields
                        }),
                    FutureBuilder<Map<String, dynamic>?>(
                        future: ownerInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(
                                'University: ${snapshot.data?["university"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                            );
                          }
                          return ListTile(
                            title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                          );

                          // Add more ListTile widgets for other data fields
                        }),
                    FutureBuilder<Map<String, dynamic>?>(
                        future: ownerInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(
                                'Hostel: ${snapshot.data?["hostel"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error retrieving owner information',style: GoogleFonts.aclonica(),),
                            );
                          }
                          return ListTile(
                            title: Text('Loading owner information...',style: GoogleFonts.aclonica(),),
                          );

                          // Add more ListTile widgets for other data fields
                        }),
                        ListTile(
                      title: Text(
                        'Description: ${data["description"]?.toString() ?? "Not Set"}',style: GoogleFonts.aclonica(),
                      ),
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
