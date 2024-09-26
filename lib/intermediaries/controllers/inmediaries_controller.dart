// controllers/intermediary_controller.dart

import 'package:campus_sell/intermediaries/models/intermediaries_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class IntermediaryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _intermediaryCollection = FirebaseFirestore.instance.collection('intermediaries');

  var intermediaries = <Intermediary>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIntermediaries();
  }

  // Fetches the list of intermediaries
  void fetchIntermediaries() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await _intermediaryCollection.get();
      intermediaries.value = snapshot.docs.map((doc) => Intermediary.fromDocument(doc)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch intermediaries.');
      print('Error fetching intermediaries: $e');
    } finally {
      isLoading(false);
    }
  }

  // Registers a new intermediary
  Future<void> registerIntermediary(String name, String email, String phone) async {
    try {
      await _intermediaryCollection.add({
        'name': name,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Intermediary registered successfully.');
      fetchIntermediaries(); // Refresh the list
    } catch (e) {
      Get.snackbar('Error', 'Failed to register intermediary.');
      print('Error registering intermediary: $e');
    }
  }
}
