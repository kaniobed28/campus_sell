import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:campus_sell/dashboard/custom_horizontal_products_list.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:campus_sell/reusable_widgets/custom_bottom_navbar.dart';
import 'package:campus_sell/reusable_widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/streamer_controller.dart';
//this is the new dashboard I used in replacement to the old one.
class NewDashboard extends StatefulWidget {
  const NewDashboard({super.key});

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  Streamer streamer = Get.find<Streamer>();
  AuthController authController = Get.find<AuthController>();

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
    
    return SafeArea(
      child:(!authController.isAuthenticated.value)?SignIn(): Scaffold(
        endDrawer: DrawerWidget(authController: authController,),
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CustomSearchBar(),
              const SizedBox(
                height: 20,
              ),
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: CustomCategoryLable(textLable: "Fashion")),
              // Obx(() {
              //   return SizedBox(
              //     height:
              //         225, //I managed the sizes of the cards here and I think it can be changed but 225 makes it not overflow as at now.
              //     child: ListView.builder(
              //       //the idea behind this builder is, I am receiveing a stream which I have made as a controller and initialized it in the main and finding it here so that I wouldnt be fetching it all the time to reduce cost.
              //       //the stream is stored in a rxlist when fetching the data and I use the list everywhere
              //       //so here what I am doing is,I am targeting each list and fetching the data that is a map from them.
              //       scrollDirection: Axis.horizontal,
              //       itemCount: lists[5].length,
              //       itemBuilder: (context, index) {
              //         final data = lists[5][index];
              //         return Padding(
              //           padding: const EdgeInsets.all(6.0),
              //           child: SmallProductCard(
              //             imageUrl: data["imagesUrls"][0],
              //             title: data["itemName"].toString().trim(),
              //             price: 'Gh¢${data["price"].toString().trim()}',
              //           ),
              //         );
              //         //  Text("${data["price"]}");
              //       },
              //     ),
              //   );
              // }),
          
              // // Food will be here
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: CustomCategoryLable(textLable: "Food")),
              // Obx(() {
              //   return SizedBox(
              //     height:
              //         225, //I managed the sizes of the cards here and I think it can be changed but 225 makes it not overflow as at now.
              //     child: ListView.builder(
              //       //the idea behind this builder is, I am receiveing a stream which I have made as a controller and initialized it in the main and finding it here so that I wouldnt be fetching it all the time to reduce cost.
              //       //the stream is stored in a rxlist when fetching the data and I use the list everywhere
              //       //so here what I am doing is,I am targeting each list and fetching the data that is a map from them.
              //       scrollDirection: Axis.horizontal,
              //       itemCount: lists[0].length,
              //       itemBuilder: (context, index) {
              //         final data = lists[0][index];
              //         return Padding(
              //           padding: const EdgeInsets.all(6.0),
              //           child: SmallProductCard(
              //             imageUrl: data["imagesUrls"][0],
              //             title: data["itemName"].toString().trim(),
              //             price: 'Gh¢${data["price"].toString().trim()}',
              //           ),
              //         );
              //         //  Text("${data["price"]}");
              //       },
              //     ),
              //   );
              // }),
              CustomHorizontalProductsList(lists: lists[5], categoryLable: 'Fashion',),
              CustomHorizontalProductsList(lists: lists[0], categoryLable: 'Food',),
              CustomHorizontalProductsList(lists: lists[1], categoryLable: 'Electronics',),
              CustomHorizontalProductsList(lists: lists[2], categoryLable: 'Health Products',),
              CustomHorizontalProductsList(lists: lists[3], categoryLable: 'Beauty Products',),
              CustomHorizontalProductsList(lists: lists[4], categoryLable: 'Jewery',),
              CustomHorizontalProductsList(lists: lists[6], categoryLable: 'Sports Products',),
              CustomHorizontalProductsList(lists: lists[7], categoryLable: 'Stationary',),
              CustomHorizontalProductsList(lists: lists[8], categoryLable: 'Kitchen Products',),
              CustomHorizontalProductsList(lists: lists[10], categoryLable: 'Services',),
              CustomHorizontalProductsList(lists: lists[9], categoryLable: 'Other Products',),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFF2F2F2 ),
      bottomNavigationBar: CustomBottomNavBar(height: 50,),
      // for the navigation bar down, I have to use smaller font size to reduce the size and the Icons too.
      // when I reduce the size, I can change the height of the navbar from here.
      ),
    );
  }
}
