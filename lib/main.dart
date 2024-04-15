import 'package:flutter/material.dart';
import 'signup_in/signup.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Signup(),
        ),
      ),
    );
  }
}
