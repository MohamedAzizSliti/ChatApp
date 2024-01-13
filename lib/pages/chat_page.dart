import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String email;
  final String uid;
  const ChatPage({super.key, required this.email, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
