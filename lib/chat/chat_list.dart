import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/individual_chat.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String currentUserId = Get.find<AuthController>().uid.value;

    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats')
            .where('participants', arrayContains: currentUserId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var chats = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              var lastMessage = chat['lastMessage'];
              var timestamp = chat['timestamp'];
              var participants = chat['participants'];
              String friendId = participants.firstWhere((id) => id != currentUserId);

              // Use FutureBuilder to fetch the friend's brand
              return FutureBuilder<Map<String, dynamic>?>(
                future: Get.find<AdditionalInfoController>().getDocumentById(friendId),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text("Loading..."),
                      subtitle: Text(lastMessage ?? ''),
                      trailing: Text(timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              timestamp.seconds * 1000).toString()
                          : ''),
                    );
                  } else if (asyncSnapshot.hasError) {
                    return ListTile(
                      title: Text("Error loading data"),
                      subtitle: Text(lastMessage ?? ''),
                      trailing: Text(timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              timestamp.seconds * 1000).toString()
                          : ''),
                    );
                  } else if (asyncSnapshot.hasData) {
                    var data = asyncSnapshot.data;
                    String? brand = data?['brand'];

                    return ListTile(
                      title: Text(brand ?? 'Unknown'),
                      subtitle: Text(lastMessage ?? ''),
                      trailing: Text(timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              timestamp.seconds * 1000).toString()
                          : ''),
                      onTap: () {
                        Get.to(() => ChatScreen(receiverId: friendId));
                      },
                    );
                  } else {
                    return ListTile(
                      title: Text("No brand info"),
                      subtitle: Text(lastMessage ?? ''),
                      trailing: Text(timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              timestamp.seconds * 1000).toString()
                          : ''),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
