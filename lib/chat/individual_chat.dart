import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/reusable_widgets/custom_fullscreen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  const ChatScreen({super.key, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  AuthController authController = Get.find<AuthController>();
  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    String senderId = authController.uid.value;
    String chatId = chatController.getChatId(senderId, widget.receiverId);

    chatController.loadMessages(chatId);
    chatController.markMessagesAsRead(chatId, senderId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>?>(
          future: Get.find<AdditionalInfoController>().getDocumentById(widget.receiverId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return const Text("Error loading brand");
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              String? brand = data?['brand'];
              return Text("Chat with ${brand ?? 'Unknown'}");
            } else {
              return const Text("No brand info");
            }
          },
        ),
        backgroundColor: Colors.amber,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed("/");
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var message = chatController.messages[index];
                  bool isSender = message['senderId'] == senderId;
                  bool isRead = (message['readBy'] as List).contains(senderId);

                  return MessageTile(
                    message: message['message'],
                    isSender: isSender,
                    isRead: isRead,
                    imageUrl: message['imageUrl'],  // Handle image display
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.blueAccent),
                  onPressed: () async {
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      String? imageUrl = await chatController.uploadImage(File(image.path));
                      if (imageUrl != null) {
                        chatController.sendMessage(
                          chatId,
                          '', // No text message, only image
                          senderId,
                          widget.receiverId,
                          imageUrl: imageUrl,
                        );
                      }
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      chatController.sendMessage(
                        chatId,
                        messageController.text,
                        senderId,
                        widget.receiverId,
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSender;
  final bool isRead;
  final String? imageUrl;

  const MessageTile({
    super.key,
    required this.message,
    required this.isSender,
    required this.isRead,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSender ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: isRead ? Colors.transparent : Colors.red,
            width: 2,
          ),
        ),
        child: imageUrl != null
            ? GestureDetector(
                onTap: () {
                  // Open image in full-screen mode
                  FullScreenImage.show(context, imageUrl!);
                },
                child: CachedNetworkImage(
                  height: 200, // Set a height for image previews
                  width: 200,
                  fit: BoxFit.fill, imageUrl:imageUrl!,
                ),
              )
            : Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
