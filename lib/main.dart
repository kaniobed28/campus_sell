import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/main_board/clicked_item.dart';
import 'package:campus_sell/signup_in/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_in/signup.dart';
import 'main_board/dashboard.dart';
// import "forms_repo/search_screen.dart";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
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
        
        child:  SignIn (),
        ),
      
    );
  }
}
