import 'package:campus_sell/auth/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart'; // Add this to use Colors

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
        middleText: "Please log in to access this page.",
        textConfirm: "Login",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.to(() => SignIn()); // Redirect to login page
        },
        textCancel: "Cancel",
        onCancel: () {
          Get.back(); // Close the dialog
        },
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
