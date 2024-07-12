import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_url_open.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/likes/controller/likes.dart';
import 'package:campus_sell/themes/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard/controllers/streamer_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  // Get.put(SearchedController());
  Get.put(AdditionalInfoController());
  Get.put(Streamer());
  // Get.put(LikeItem());
  // Get.put(PagesStateController());
  runApp( const MainApp());
}

class MainApp extends StatelessWidget {
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: lightTheme,
      home: const SafeArea(
        
        child:  NewDashboard (),
        ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const NewDashboard()),
        GetPage(name: '/:id', page: () =>  const AgoTechUrlOpen()),
      ],
      navigatorKey: Get.key, 
    );
  }
}
