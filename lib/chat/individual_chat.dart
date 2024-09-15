import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/chat_controller.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    String senderId = Get.find<AuthController>().uid.value;
    String chatId = chatController.getChatId(senderId, widget.receiverId);

    // Load messages for this chat
    chatController.loadMessages(chatId);

    // Mark messages as read
    chatController.markMessagesAsRead(chatId, senderId);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>?>(
          future:
              Get.find<AdditionalInfoController>().getDocumentById(widget.receiverId),
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
            Get.toNamed("/"); // Navigates to the root route ("/")
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
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
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

// Custom widget for each message
class MessageTile extends StatelessWidget {
  final String message;
  final bool isSender;
  final bool isRead;

  const MessageTile({super.key, 
    required this.message,
    required this.isSender,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSender ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isRead
                ? Colors.transparent
                : Colors.red, // Indicate unread messages with a border
            width: 2,
          ),
        ),
        child: Text(
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
