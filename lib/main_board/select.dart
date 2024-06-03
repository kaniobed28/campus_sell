import 'package:campus_sell/all_type_screen.dart';
import 'package:campus_sell/main_board/dashboard/controllers/streamer_controller.dart';
import 'package:campus_sell/main_board/dashboard/views/type_card.dart';
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
          double heighttOfScreen =
        MediaQuery.of(context).size.height;
        double widthOfScreen = MediaQuery.of(context).size.width;


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
          //I dont understand but there is something wrong with the height here.
          // whene I make it cover the uncovered space, it does not show everything.
           SizedBox(
            width: widthOfScreen,
            height: heighttOfScreen-200,
             child: PageView(
                children: [
                  SingleChildScrollView(child: AllTypeHome()),
                  TypeCard(typeList: streamer.foodList),
                  TypeCard(typeList: streamer.fashionList),
                  TypeCard(typeList: streamer.beautyList),
                  TypeCard(typeList: streamer.kitchenList),
                  TypeCard(typeList: streamer.electronicList),
                  TypeCard(typeList: streamer.sportsList),
                  TypeCard(typeList: streamer.stationeryList),
                  TypeCard(typeList: streamer.healthcareList),
                  TypeCard(typeList: streamer.jewelryList),
                  TypeCard(typeList: streamer.othersList),
                ],
              ),
           ),
          
        ],
      ),
    );
  }
}

class SelectableTextController extends GetxController {
  RxInt selectedIndex = (-1).obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
