import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList messages = [].obs;

  // Load messages for a specific chat between sender and receiver
  void loadMessages(String chatId) {
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      messages.clear();
      snapshot.docs.forEach((doc) {
        messages.add(doc.data());
      });
    });
  }

  // Send message to a specific chat
  Future<void> sendMessage(String chatId, String message, String senderId, String receiverId) async {
    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message in chat document
    await _firestore.collection('chats').doc(chatId).set({
      'participants': [senderId, receiverId],
      'lastMessage': message,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
// Generate chatId for two users
String getChatId(String userAId, String userBId) {
  // Combine user IDs by comparing them to create a unique chatId
  return userAId.compareTo(userBId) > 0 ? "${userBId}_$userAId" : "${userAId}_$userBId";
}
}