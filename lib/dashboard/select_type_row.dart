import 'package:campus_sell/dashboard/controllers/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectableTextRow extends StatelessWidget {
  final SelectableTextController controller = Get.put(SelectableTextController());

  final List<String> categories = [
    'All',
    'Food',
    'Fashion',
    'Beauty Products',
    'Kitchen',
    'Electronic',
    'Sports',
    'Stationery',
    'Health',
    'Jewelry',
    'Others'
  ];
    Streamer streamer = Get.put(Streamer());
  @override
  Widget build(BuildContext context) {


    return SliverToBoxAdapter(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Row(
                children: categories.asMap().entries.map((entry) {
                  int index = entry.key;
                  String category = entry.value;
                  return GestureDetector(
                    onTap: () {

                     
                      controller.setSelectedIndex(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Changed to ${categories[index]}',style: GoogleFonts.aclonica(),),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      // Get.to(() => Fash());
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex == index ? const Color.fromARGB(255, 33, 33, 34) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          category,
                          style: TextStyle(fontFamily: GoogleFonts.average().fontFamily,fontWeight: FontWeight.w800 ,
                            color: controller.selectedIndex == index ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

class SelectableTextController extends GetxController {
  RxInt selectedIndex = (0).obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
