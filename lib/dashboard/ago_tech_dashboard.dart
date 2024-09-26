import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/device_controller.dart';
import 'package:campus_sell/dashboard/categories_pages.dart';
import 'package:campus_sell/dashboard/custom_horizontal_products_list.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/reusable_widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/streamer_controller.dart';

class NewDashboard extends StatefulWidget {
  NewDashboard({super.key});

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  final PageController _pageController = PageController(); // Step 1
  Streamer streamer = Get.find<Streamer>();
  AuthController authController = Get.find<AuthController>();
  final DeviceController deviceController = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
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
      streamer.servicesList
    ];

    final categories = [
      'All',
      'Food',
      'Electronics',
      'Health Products',
      'Beauty Products',
      'Jewelry',
      'Fashion',
      'Sports Products',
      'Stationery',
      'Kitchen Products',
      'Services',
      'Other Products',
    ];

    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerWidget(authController: authController),
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 5),
            const CustomSearchBar(),
            const SizedBox(height: 5),

            // Step 3: Navigation buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.teal),
                        elevation: WidgetStateProperty.all<double>(
                            10.0), // This adds the raised effect
                      ),
                      onPressed: () {
                        _pageController.jumpToPage(
                            index); // Navigate to the respective page
                      },
                      child: Text(
                        categories[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController, // Step 2
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomHorizontalProductsList(
                          lists: lists[10],
                          categoryLabel: 'Services',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[5],
                          categoryLabel: 'Fashion',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[0],
                          categoryLabel: 'Food',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[1],
                          categoryLabel: 'Electronics',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[2],
                          categoryLabel: 'Health Products',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[3],
                          categoryLabel: 'Beauty Products',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[4],
                          categoryLabel: 'Jewelry',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[6],
                          categoryLabel: 'Sports Products',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[7],
                          categoryLabel: 'Stationery',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[8],
                          categoryLabel: 'Kitchen Products',
                        ),
                        CustomHorizontalProductsList(
                          lists: lists[9],
                          categoryLabel: 'Other Products',
                        ),
                      ],
                    ),
                  ),
                  FoodPage(foodList: lists[0]),
                  ElectronicsPage(electronicList: lists[1]),
                  HealthPage(healthList: lists[2]),
                  BeautyPage(beautyList: lists[3]),
                  JewelryPage(jewelryList: lists[4]),
                  FashionPage(fashionList: lists[5]),
                  SportsPage(sportsList: lists[6]),
                  StationaryPage(stationaryList: lists[7]),
                  KitchenPage(kitchenList: lists[8]),
                  ServicesPage(servicesList: lists[10]),
                  OtherPage(otherList: lists[9]),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF2F2F2),
        bottomNavigationBar: Visibility(
          visible: !deviceController.isWeb.value,
          child: CustomBottomNavBar(height: 50),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/chats");
          },
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
