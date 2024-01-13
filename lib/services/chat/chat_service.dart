import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> SendMessage(String reciverId, String message) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create new message
    Message newMessage = Message(
        senderId: currentUserId,
        reciverId: reciverId,
        message: message,
        senderEmail: currentUserEmail,
        timestamp: timestamp);
    //construct room chat id
    List<String> ids = [reciverId, currentUserId];
    ids.sort();
    String chatRoom = ids.join("_");
    //add new message in database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> GetMessages(String userId, String otherId)  {
    //construct room chat id
    List<String> ids = [userId, otherId];
    ids.sort();
    String chatRoom = ids.join("_");

   return   _firestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection("messages")
        .orderBy("timestamp", descending: false).snapshots();
  }
}
