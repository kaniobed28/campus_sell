import 'package:flutter/material.dart';
import 'signup_in/signup.dart';
// import "forms_repo/search_screen.dart";
void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // routes: {
      //   "/": (context)=> SearchScreen(),
      //   "SignUp": (context)=> Signup(),
      // },
      theme: ThemeData(primaryColor: Colors.amber),
      home: SafeArea(
        child:  Signup(),
        ),
      
    );
  }
}
