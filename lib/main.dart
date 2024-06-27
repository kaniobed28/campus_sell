import 'package:campus_sell/clicked_item/clicked_item%20copy.dart';
import 'package:campus_sell/clicked_item/clicked_item.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/auth/views/signin.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/list_screen.dart';
import 'package:campus_sell/themes/theme_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      
      theme: lightTheme,
      home: SafeArea(
        
        child:  SignIn (),
        ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignIn()),
        // GetPage(name: '/listscreen', page: () => const ListScreen()),
        GetPage(name: '/:id', page: () =>  ClickedItemC()),
      ],
      navigatorKey: Get.key, 
    );
  }
}
