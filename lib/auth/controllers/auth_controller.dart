import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
         uid.value=  userCredential.user!.uid;

      return userCredential.user;
    } catch (e) {
      // print("Sign-in error: $e");
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          uid.value=  userCredential.user!.uid;
          print(uid.value);
      return userCredential.user;
    } catch (e) {
      // print("Sign-up error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      isAuthenticated.value = false;
      uid.value = '';
    } catch (e) {
      // print("Sign-out error: $e");
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
