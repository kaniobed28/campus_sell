import 'package:campus_sell/dashboard/streamer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                          content: Text('You clicked on $index'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      // Get.to(() => Fash());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex == index ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          category,
                          style: TextStyle(
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
