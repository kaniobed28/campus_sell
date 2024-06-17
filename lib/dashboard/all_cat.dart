import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/clicked_item/clicked_item.dart';
import 'package:campus_sell/dashboard/controllers/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Streamer streamer = Get.put(Streamer());
    final double widthOfScreen = MediaQuery.of(context).size.width;

    final lists = [
      streamer.foodList,
      streamer.electronicList,
      streamer.healthcareList,
      streamer.beautyList,
      streamer.jewelryList,
      streamer.fashionList,
      streamer.sportsList,
      streamer.stationeryList,
      streamer.kitchenList,
      streamer.othersList,
    ];

    return SingleChildScrollView(
      child: Column(
        children: lists.map((list) => DisplayCard(list, widthOfScreen)).toList(),
      ),
    );
  }

  Obx DisplayCard(RxList<Map<String, dynamic>> items, double widthOfScreen) {
    return Obx(() {
      return SizedBox(
        height: 280,
        width: widthOfScreen * 0.99,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => const ClickedItem(), arguments: item);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: item['imagesUrls'][0],
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 280,
                          width: 200,
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
                            color: Color.fromARGB(255, 248, 255, 41).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Gh¢ ${item['price'].toString().trim()}",
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
                              children: [
                                Text(
                                  item['itemName'].toString().trim(),
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
                                  "Gh¢ ${item['price'].toString().trim()}",
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
              ),
            );
          },
        ),
      );
    });
  }
}
