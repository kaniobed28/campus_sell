import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/all_cat.dart';
import 'package:campus_sell/dashboard/cus_appbar.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/dashboard/select_type_row.dart';
import 'package:campus_sell/dashboard/controllers/streamer_controller.dart';
import 'package:campus_sell/dashboard/type_card.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(DashBoard());
}

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  final AuthController authController = Get.put(AuthController());
      Streamer streamer = Get.put(Streamer());

  final SelectableTextController selectableTextController = Get.put(SelectableTextController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          endDrawer: DrawerWidget(authController: authController),
          // appBar: AppBar(
          //   title: Text('Dashboard'),
          // ),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const CusAppBar(),
                SelectableTextRow(),
              ];
            },
            body:  Obx(
          () {
            if (selectableTextController.selectedIndex.value == 0) {
        return const CategoryBody();
            } 
            else if (selectableTextController.selectedIndex.value == 1) {
        return Center(
          child: TypeCard(typeList: streamer.foodList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 2) {
        return Center(
          child: TypeCard(typeList: streamer.fashionList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 3) {
        return Center(
          child: TypeCard(typeList: streamer.beautyList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 4) {
        return Center(
          child: TypeCard(typeList: streamer.kitchenList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 5) {
        return Center(
          child: TypeCard(typeList: streamer.electronicList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 6) {
        return Center(
          child: TypeCard(typeList: streamer.sportsList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 7) {
        return Center(
          child: TypeCard(typeList: streamer.stationeryList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 8) {
        return Center(
          child: TypeCard(typeList: streamer.healthcareList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 9) {
        return Center(
          child: TypeCard(typeList: streamer.jewelryList),
        );
            } 
            else if (selectableTextController.selectedIndex.value == 10) {
        return Center(
          child: TypeCard(typeList: streamer.othersList),
        );
            } 
            else {
        // Return a different widget based on the condition
        return const Center(
          child: Text('Condition not met'),
        );
            }
          },
        ),
          ),
        
      
    );
  }
}


