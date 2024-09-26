import 'package:campus_sell/auth/views/signin.dart';
import 'package:campus_sell/auth/views/signup.dart';
import 'package:campus_sell/chat/chat_controller.dart';
import 'package:campus_sell/chat/chat_list.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/device_controller.dart';
import 'package:campus_sell/dashboard/ago_tech_dashboard.dart';
import 'package:campus_sell/dashboard/ago_tech_sell_screen.dart';
import 'package:campus_sell/dashboard/ago_tech_url_open.dart';
import 'package:campus_sell/dashboard/basket_screen.dart';
import 'package:campus_sell/dashboard/controllers/basket_controller.dart';
import 'package:campus_sell/dashboard/controllers/is_owner_controller.dart';
import 'package:campus_sell/firebase_options.dart';
import 'package:campus_sell/follow/controllers/follow_controller.dart';
import 'package:campus_sell/forms_repo/seller_info_screen.dart';
import 'package:campus_sell/list_screen.dart';
import 'package:campus_sell/main_board/delete_page.dart';
import 'package:campus_sell/search/views/search_screen.dart';
import 'package:campus_sell/themes/theme_constants.dart';
import 'package:campus_sell/viewers/controllers/viewers_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard/controllers/streamer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(AdditionalInfoController());
  Get.put(Streamer());
  Get.put(IsOwnerController());
  Get.put(BasketController());
  Get.put(DeviceController());
  Get.put(ChatController());
  Get.put(FollowController());
  Get.put(ViewController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SafeArea(
        child: NewDashboard(),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => NewDashboard(),
          transition: Transition.cupertino, // Cupertino transition
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shop',
          page: () => NewDashboard(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/chats',
          page: () => const ChatListScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems',
          page: () => NewDashboard(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/itemcode/:id',
          page: () => const AgoTechUrlOpen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shop/shopitems/:id',
          page: () => ListScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shop/basket',
          page: () => BasketScreen(userId: authController.uid.value),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/myitems',
          page: () => ListScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/removeitems',
          page: () => const DeleteScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/addtoshop',
          page: () => const AgoTechSellScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/profile',
          page: () => SellInfoScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/multisearch',
          page: () => SearchScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/shopitems/addtostore',
          page: () => const AgoTechSellScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/auth/signin',
          page: () => SignIn(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/auth/signup',
          page: () => Signup(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ],
      navigatorKey: Get.key,
    );
  }
}
