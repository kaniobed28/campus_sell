import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdditionalInfoController extends GetxController {
  final authController = Get.find<AuthController>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String brandName = "";
  String cityName = "";
  late String universityName;
  late String addressName;
  late String phoneNumber;
  late String socialMedia;


  Future<Map<String, dynamic>> getAllDataFromProfile(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('add_info').doc(uid).get();
     
    Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
    brandName = data['brand'];
    cityName = data['city'];
    universityName = data["university"];
    addressName = data['hostel'];
    phoneNumber = data['phone'];
    socialMedia = data['socialMedia'];
  
    return data;
  }





  Future<void> addDataToFirestore(
      Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).set(data);
        // print('Data added successfully');
      } else {
        // print('Error: Data is empty or null');
      }
    } catch (e) {
      // print('Error adding data: $e');
    }
  }

  Future<void> updateDataInFirestore(
      Map<String, dynamic>? data, String uid) async {
    try {
      if (data != null) {
        await firebaseFirestore.collection('add_info').doc(uid).update(data);
        // print('Data updated successfully');
      } else {
        // print('Error: Data is empty or null');
      }
    } catch (e) {
      // print('Error updating data: $e');
    }
  }

// this function updates both the additional info and the items collection together
  Future<void> updateWithAddInfo() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    AuthController authController = Get.put(AuthController());
    if (authController.isAuthenticated.value) {
      DocumentSnapshot<Map<String, dynamic>> snapshota = await firebaseFirestore
          .collection("add_info")
          .doc(authController.uid.string)
          .get();
      Map<String, dynamic> data = snapshota.data() as Map<String, dynamic>;

      QuerySnapshot snapshot = await firebaseFirestore
          .collection("items")
          .where("ownerId", isEqualTo: authController.uid.string)
          .get();
      snapshot.docs.forEach((element) {
        firebaseFirestore.collection("items").doc(element.id).update(data);
      });
    } else {}
  }

  //it will be more efficient if I use id here instead of name but I will change it later
  Future<void> updateAnItemWithAddInfo(String itemName) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    AuthController authController = Get.put(AuthController());
    if (authController.isAuthenticated.value) {
      DocumentSnapshot<Map<String, dynamic>> snapshota = await firebaseFirestore
          .collection("add_info")
          .doc(authController.uid.string)
          .get();
      Map<String, dynamic> data = snapshota.data() as Map<String, dynamic>;

      QuerySnapshot snapshot = await firebaseFirestore
          .collection("items")
          .where("ownerId", isEqualTo: authController.uid.string)
          .where("itemName", isEqualTo: itemName)
          .get();
      for (var element in snapshot.docs) {
        firebaseFirestore.collection("items").doc(element.id).update(data);
      }
    } else {}
  }

  Future<Map<String, dynamic>?> getDocumentById(String docId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore.collection('add_info').doc(docId).get();
      if (snapshot.exists) {
        // print('Document data: ${snapshot.data()}');
        return snapshot.data();
      } else {
        // print('Document does not exist');
        return null;
      }
    } catch (e) {
      // print('Error getting document: $e');
      throw e;
    }
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //  await getAllDataFromProfile(authController.uid.value);
  // }
}
