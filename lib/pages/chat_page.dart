import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final String uid;
  const ChatPage({super.key, required this.email, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _chatService.SendMessage(widget.uid, _messageController.text);
      //clean the controller affter send the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildMessgeInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.GetMessages(widget.uid, _auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data["senderId"] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data["senderId"] == _auth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(data["senderEmail"]),
              SizedBox(
                height: 8,
              ),
              ChatBubble(
                  message: data["message"],
                  color: (data["senderId"] == _auth.currentUser!.uid)
                      ? Colors.blue.shade300
                      : Colors.grey.shade400)
            ],
          ),
        ));
  }

  Widget _buildMessgeInput() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          Expanded(
              child: MytextField(
            controller: _messageController,
            hintText: "Enter Message",
            obscureText: false,
          )),
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                size: 40,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
