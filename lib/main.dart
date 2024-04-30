import 'package:campus_sell/main_board/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_in/signup.dart';
import 'main_board/dashboard.dart';
// import "forms_repo/search_screen.dart";
void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   "/": (context)=> SearchScreen(),
      //   "SignUp": (context)=> Signup(),
      // },
      theme: ThemeData(primaryColor: Colors.amber),
      home: SafeArea(
        child:  Signup (),
        ),
      
    );
  }
}
