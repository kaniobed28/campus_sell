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

  GestureDetector displayCard(List<Map<String, dynamic>> filteredItems, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ClickedItem(), arguments: filteredItems[index]);
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: filteredItems[index]['imagesUrls'][0],
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.025),
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "GH¢ ${filteredItems[index]['price'].toString().trim()}",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.99),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        filteredItems[index]['itemName'].toString().trim(),
                        style: GoogleFonts.aclonica(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "GH¢ ${filteredItems[index]['price'].toString().trim()}",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (screenWidth >= 800) {
      crossAxisCount = 4;
    } else if (screenWidth >= 450) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    return crossAxisCount;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _calculateCrossAxisCount(context),
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
