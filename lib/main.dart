import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  // Get.put(SearchedController());
  Get.put(AdditionalInfoController());
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 255, 255, 255)),
      home: SafeArea(
        
        child:  SignIn (),
        ),
      
    );
  }
}
