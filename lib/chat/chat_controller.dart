import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';

class ChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      for (var doc in snapshot.docs) {
        messages.add(doc.data());
      }
    });
  }

  // Send message or image to a specific chat
  Future<void> sendMessage(String chatId, String message, String senderId, String receiverId, {String? imageUrl}) async {
    // Message data
    Map<String, dynamic> messageData = {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'readBy': [senderId],  // Initially, the sender has read the message
    };

    // If an image URL is provided, add it to the message data
    if (imageUrl != null) {
      messageData['imageUrl'] = imageUrl;
    }

    // Add the message to Firestore
    DocumentReference messageRef = await _firestore.collection('chats').doc(chatId).collection('messages').add(messageData);

    // Update the last message in the chat document
    await _firestore.collection('chats').doc(chatId).set({
      'participants': [senderId, receiverId],
      'lastMessage': message.isNotEmpty ? message : 'Image sent',
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Upload image to Firebase Storage
  Future<String?> uploadImage(File image) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot storageSnapshot = await uploadTask;
      String downloadUrl = await storageSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  // Mark all messages as read by a specific user
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    QuerySnapshot messagesSnapshot = await _firestore.collection('chats').doc(chatId).collection('messages').get();

    // Iterate over each message and update the readBy field
    for (QueryDocumentSnapshot doc in messagesSnapshot.docs) {
      DocumentReference messageRef = doc.reference;
      await messageRef.update({
        'readBy': FieldValue.arrayUnion([userId]),
      });
    }
  }

  // Count unread messages
  Future<int> countUnreadMessages(String chatId, String userId) async {
    QuerySnapshot messagesSnapshot = await _firestore.collection('chats').doc(chatId).collection('messages').get();
    int unreadCount = 0;
    for (QueryDocumentSnapshot doc in messagesSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<dynamic> readBy = data['readBy'] ?? [];
      if (!readBy.contains(userId)) {
        unreadCount++;
      }
    }
    return unreadCount;
  }

  // Generate chatId for two users
  String getChatId(String userAId, String userBId) {
    return userAId.compareTo(userBId) > 0 ? "${userBId}_$userAId" : "${userAId}_$userBId";
  }
}
