// import 'dart:async';
// import 'package:campus_sell/firebase_options.dart';
// import 'package:campus_sell/main_board/dashboard/controllers/streamer_controller.dart';
// import 'package:campus_sell/main_board/dashboard/views/type_card.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final Streamer streamer = Get.put(Streamer());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore Items Grid'),
//       ),
//       body: TypeCard(
//         typeList: streamer.fashionList,
//       ),
//     );
//   }
// }


