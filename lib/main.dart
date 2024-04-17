import 'package:flutter/material.dart';
import 'signup_in/signup.dart';
void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber),
      home: SafeArea(
        child:  Signup(),
        ),
      
    );
  }
}
