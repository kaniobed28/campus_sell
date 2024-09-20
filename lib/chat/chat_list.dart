import 'package:campus_sell/auth/controllers/auth_controller.dart';
import 'package:campus_sell/chat/chat_controller.dart';
import 'package:campus_sell/chat/individual_chat.dart';
import 'package:campus_sell/controllers/additional_info_controller.dart';
import 'package:campus_sell/dashboard/drawer.dart';
import 'package:campus_sell/reusable_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ChatController chatController = Get.find<ChatController>();
  final AuthController authController = Get.find<AuthController>();

  // Custom function to format the timestamp
  String formatTimestamp(Timestamp timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return "now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }



@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = Get.find<AuthController>().uid.value;

    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerWidget(authController: authController),
        appBar:  const CustomAppBar(),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('chats')
              .where('participants', arrayContains: currentUserId)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var chats = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chats.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemBuilder: (context, index) {
                var chat = chats[index];
                var lastMessage = chat['lastMessage'];
                var timestamp = chat['timestamp'];
                var participants = chat['participants'];
                String friendId = participants.firstWhere((id) => id != currentUserId);
                String chatId = chatController.getChatId(currentUserId, friendId);

                return FutureBuilder<Map<String, dynamic>?>( 
                  future: Get.find<AdditionalInfoController>().getDocumentById(friendId),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                      return ChatTile(
                        brand: "Loading...",
                        lastMessage: lastMessage ?? '',
                        timestamp: timestamp != null ? formatTimestamp(timestamp) : '',
                        unreadCount: 0,
                        icon: Icons.hourglass_empty,
                      );
                    } else if (asyncSnapshot.hasError) {
                      return ChatTile(
                        brand: "Error loading data",
                        lastMessage: lastMessage ?? '',
                        timestamp: timestamp != null ? formatTimestamp(timestamp) : '',
                        unreadCount: 0,
                        icon: Icons.error,
                      );
                    } else if (asyncSnapshot.hasData) {
                      var data = asyncSnapshot.data;
                      String? brand = data?['brand'];

                      return FutureBuilder<int>(
                        future: chatController.countUnreadMessages(chatId, currentUserId),
                        builder: (context, countSnapshot) {
                          int unreadCount = countSnapshot.data ?? 0;

                          return ChatTile(
                            brand: brand ?? 'Unknown',
                            lastMessage: lastMessage ?? '',
                            timestamp: timestamp != null ? formatTimestamp(timestamp) : '',
                            unreadCount: unreadCount,
                            onTap: () {
                              Get.to(() => ChatScreen(receiverId: friendId));
                            },
                          );
                        },
                      );
                    } else {
                      return ChatTile(
                        brand: "No brand info",
                        lastMessage: lastMessage ?? '',
                        timestamp: timestamp != null ? formatTimestamp(timestamp) : '',
                        unreadCount: 0,
                        icon: Icons.help_outline,
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Custom widget for each chat tile
class ChatTile extends StatelessWidget {
  final String brand;
  final String lastMessage;
  final String timestamp;
  final VoidCallback? onTap;
  final IconData? icon;
  final int unreadCount;

  const ChatTile({super.key, 
    required this.brand,
    required this.lastMessage,
    required this.timestamp,
    this.onTap,
    this.icon,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                icon ?? Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
