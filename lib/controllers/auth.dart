import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth  auth = FirebaseAuth.instance;

  Future  signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email ,password: password);
     
     }
    catch(e){
      print(e);
    }
}
}