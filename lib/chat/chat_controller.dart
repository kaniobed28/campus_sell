import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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

  // Send message to a specific chat
  Future<void> sendMessage(String chatId, String message, String senderId, String receiverId) async {
    // Add the message to the messages collection
    DocumentReference messageRef = await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'readBy': [senderId],  // Initially, the sender has read the message
    });

    // Update last message in the chat document
    await _firestore.collection('chats').doc(chatId).set({
      'participants': [senderId, receiverId],
      'lastMessage': message,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Mark all messages as read by a specific user
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    // Get all messages in the chat
    QuerySnapshot messagesSnapshot = await _firestore.collection('chats').doc(chatId).collection('messages').get();

    // Iterate over each message and update the readBy field
    for (QueryDocumentSnapshot doc in messagesSnapshot.docs) {
      DocumentReference messageRef = doc.reference;
      await messageRef.update({
        'readBy': FieldValue.arrayUnion([userId]),
      });
    }
  }
Future<int> countUnreadMessages(String chatId, String userId) async {
  QuerySnapshot messagesSnapshot = await _firestore.collection('chats').doc(chatId).collection('messages')
      .get();

  // Count messages where the userId is not in the readBy list
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
    // Combine user IDs by comparing them to create a unique chatId
    return userAId.compareTo(userBId) > 0 ? "${userBId}_$userAId" : "${userAId}_$userBId";
  }
}
