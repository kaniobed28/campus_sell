import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/clicked_item/clicked_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeCard extends StatelessWidget {
  const TypeCard({
    super.key,
    required this.typeList,
  });

  final RxList<dynamic> typeList;

  Stack displayCard(List<Map<String, dynamic>> filteredItems, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(const ClickedItem(),
                      arguments: filteredItems[index]),
          child: Padding(
            padding: const EdgeInsets.all(0.0),//I didnt use this padding because I used it else where
            child: SizedBox(
              height: 170+46,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)), // Adjust the radius as needed
                child: CachedNetworkImage(
                  height: 170,
                  imageUrl: filteredItems[index]['imagesUrls'][0],
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 222, 222, 222),
                        ),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: const Offset(
                                -2, 5), // changes the position of the shadow
                          ),
                        ],
                      ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      filteredItems[index]['itemName'].toString().trim(),
                      style: GoogleFonts.aclonica(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "GHS ${filteredItems[index]['price'].toString().trim()}",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: typeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: displayCard(typeList.cast<Map<String, dynamic>>(), index),
          );
        },
      );
    });
  }
}