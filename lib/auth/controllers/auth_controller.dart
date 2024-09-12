import 'package:campus_sell/auth/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Add this to use Colors

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isAuthenticated = false.obs;
  RxString uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isAuthenticated.value = true;
        uid.value = user.uid;
      } else {
        isAuthenticated.value = false;
        uid.value = '';
      }
    });
  }

  // Method to check authentication and show dialog if not authenticated
  void checkAuthentication() {
  if (isAuthenticated.isFalse) {
    Get.defaultDialog(
      title: "Authentication Required",
      titleStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.lock_outline,
            color: Colors.redAccent,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            "Please log in to access this page.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      barrierDismissible: false, // Prevent dismissal by tapping outside
      radius: 10, // Rounded corners for the dialog
      confirm: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(Icons.login, color: Colors.black),
        label: const Text("Login",style:  TextStyle(color: Colors.black),),
        onPressed: () {
          Get.to(() => SignIn()); // Redirect to login page
        },
      ),
      cancel: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.redAccent), // Border color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(Icons.cancel, color: Colors.redAccent),
        label: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
        onPressed: () {
          Get.toNamed("/"); // Close the dialog
        },
      ),
    );
  }
}


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      uid.value = userCredential.user!.uid;

      return userCredential.user;
    } catch (e) {
      // Handle sign-in error
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      uid.value = userCredential.user!.uid;
      return userCredential.user;
    } catch (e) {
      // Handle sign-up error
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      isAuthenticated.value = false;
      uid.value = '';
    } catch (e) {
      // Handle sign-out error
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Password Reset',
        'A password reset link has been sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send password reset email',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }
}
