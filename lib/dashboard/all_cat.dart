import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/clicked_item/clicked_item.dart';
import 'package:campus_sell/dashboard/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Streamer streamer = Get.put(Streamer());
    if (streamer.isClosed) {
      Streamer streamer = Get.put(Streamer());
    }

    RxList<Map<String, dynamic>> fashionListstreamer =
        Get.find<Streamer>().fashionList;
    RxList<Map<String, dynamic>> electronicListstreamer =
        Get.find<Streamer>().electronicList;
    RxList<Map<String, dynamic>> beautyListstreamer =
        Get.find<Streamer>().beautyList;
    RxList<Map<String, dynamic>> healthcareListstreamer =
        Get.find<Streamer>().healthcareList;
    RxList<Map<String, dynamic>> stationeryListstreamer =
        Get.find<Streamer>().stationeryList;
    RxList<Map<String, dynamic>> jewelryListstreamer =
        Get.find<Streamer>().jewelryList;
    RxList<Map<String, dynamic>> foodListstreamer =
        Get.find<Streamer>().foodList;
    RxList<Map<String, dynamic>> sportsListstreamer =
        Get.find<Streamer>().sportsList;
    RxList<Map<String, dynamic>> kitchenListstreamer =
        Get.find<Streamer>().kitchenList;
    RxList<Map<String, dynamic>> othersListstreamer =
        Get.find<Streamer>().othersList;
    return SingleChildScrollView(
      child: Column(
        children: [
          DisplayCard(foodListstreamer),
          DisplayCard(electronicListstreamer),
          DisplayCard(healthcareListstreamer),
          DisplayCard(beautyListstreamer),
          DisplayCard(jewelryListstreamer),
          DisplayCard(fashionListstreamer),
          DisplayCard(sportsListstreamer),
          DisplayCard(stationeryListstreamer),
          DisplayCard(kitchenListstreamer),
          DisplayCard(othersListstreamer),
        ],
      ),
    );
  }

  Obx DisplayCard(var itemDependancyClass) {
    return Obx(() {
      return SizedBox(
        height: 250,
        width: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemDependancyClass.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: CachedNetworkImage(
                          height: 350,
                          imageUrl: itemDependancyClass[index]['imagesUrls'][0],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
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
                                  itemDependancyClass[index]['itemName']
                                      .toString()
                                      .trim(),
                                  style: GoogleFonts.aclonica(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                  "Ghs ${itemDependancyClass[index]["price"].toString().trim()}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                print(itemDependancyClass[index]);
                 Get.to(() =>const ClickedItem(),
                      arguments: itemDependancyClass[index]);
          });
          },
        ),
      );
    });
  }
}
