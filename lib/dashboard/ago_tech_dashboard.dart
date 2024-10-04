import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/device_controller.dart';
import 'package:campus_sell/dashboard/categories_pages.dart';
import 'package:campus_sell/dashboard/custom_horizontal_products_list.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/main_board/custom_appbar/views/custom_appbar.dart';
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
  final PageController _pageController = PageController();
  final Streamer streamer = Get.find<Streamer>();
  final AuthController authController = Get.find<AuthController>();
  final DeviceController deviceController = Get.find<DeviceController>();

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All', 'Food', 'Electronics', 'Health Products', 'Beauty Products',
      'Jewelry', 'Fashion', 'Sports Products', 'Stationery', 'Kitchen Products',
      'Services', 'Other Products',
    ];

    return SafeArea(
      child: Scaffold(
        
        endDrawer: DrawerWidget(authController: authController),
        appBar:  CustomAppBar(elevation: 0,),
        body: Column(
          children: [
            const SizedBox(height: 5),
            const CustomSearchBar(),
            const SizedBox(height: 5),
            // Navigation buttons with optimized styling
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 254),
                        elevation: 10.0,
                      ),
                      onPressed: () {
                        int index = categories.indexOf(category);
                        _pageController.jumpToPage(index);
                      },
                      child: Text(
                        category,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // "All" category page
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomHorizontalProductsList(
                            lists: streamer.servicesList,
                            categoryLabel: 'Services',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.fashionList,
                            categoryLabel: 'Fashion',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.foodList,
                            categoryLabel: 'Food',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.electronicList,
                            categoryLabel: 'Electronics',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.healthcareList,
                            categoryLabel: 'Health Products',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.beautyList,
                            categoryLabel: 'Beauty Products',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.jewelryList,
                            categoryLabel: 'Jewelry',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.sportsList,
                            categoryLabel: 'Sports Products',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.stationeryList,
                            categoryLabel: 'Stationery',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.kitchenList,
                            categoryLabel: 'Kitchen Products',
                          ),
                          CustomHorizontalProductsList(
                            lists: streamer.othersList,
                            categoryLabel: 'Other Products',
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Specific category pages
                    switch (index) {
                      case 1:
                        return FoodPage(foodList: streamer.foodList);
                      case 2:
                        return ElectronicsPage(electronicList: streamer.electronicList);
                      case 3:
                        return HealthPage(healthList: streamer.healthcareList);
                      case 4:
                        return BeautyPage(beautyList: streamer.beautyList);
                      case 5:
                        return JewelryPage(jewelryList: streamer.jewelryList);
                      case 6:
                        return FashionPage(fashionList: streamer.fashionList);
                      case 7:
                        return SportsPage(sportsList: streamer.sportsList);
                      case 8:
                        return StationaryPage(stationaryList: streamer.stationeryList);
                      case 9:
                        return KitchenPage(kitchenList: streamer.kitchenList);
                      case 10:
                        return ServicesPage(servicesList: streamer.servicesList);
                      case 11:
                        return OtherPage(otherList: streamer.othersList);
                      default:
                        return OtherPage(otherList: streamer.othersList);
                    }
                  }
                },
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF2F2F2),
        bottomNavigationBar: Visibility(
          visible: !deviceController.isWeb.value,
          child:  CustomBottomNavBar(height: 50),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/chats");
          },
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child:  Icon(
            Icons.chat,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
