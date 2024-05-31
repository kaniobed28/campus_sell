import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/signup_in/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  // Get.put(SearchedController());
  Get.put(AdditionalInfoController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   "/": (context)=> SearchScreen(),
      //   "SignUp": (context)=> Signup(),
      // },
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 255, 255)),
      home: SafeArea(
        child: SignIn(),
      ),
    );
  }
}
