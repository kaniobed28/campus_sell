import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditItemController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to update a specific field in an item document
  Future<void> updateField(String itemId, String fieldName, dynamic newValue) async {
    try {
      // Reference to the item document with the specified itemId
      DocumentReference itemRef = _firestore.collection('items').doc(itemId);

      // Update only the specified field
      await itemRef.update({fieldName: newValue.toString().capitalizeFirst});

      // Notify success
      Get.snackbar('Success', 'Field updated successfully');
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to update field: $e');
    }
  }
}
