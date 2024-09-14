import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/chat_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final String receiverId;

  ChatScreen({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    String senderId = Get.find<AuthController>().uid.value;
    String chatId = chatController.getChatId(senderId, receiverId);

    // Load messages for this chat
    chatController.loadMessages(chatId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>?>(
          future: Get.find<AdditionalInfoController>().getDocumentById(receiverId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error loading brand");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              String? brand = data?['brand'];
              return Text("Chat with ${brand ?? 'Unknown'}");
            } else {
              return Text("No brand info");
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var message = chatController.messages[index];
                  bool isSender = message['senderId'] == senderId;
                  return ListTile(
                    title: Align(
                      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSender ? Colors.green[100] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['message']),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(labelText: "Enter a message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      chatController.sendMessage(
                        chatId,
                        messageController.text,
                        senderId,
                        receiverId,
                      );
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
