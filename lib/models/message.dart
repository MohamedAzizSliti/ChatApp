import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String message;
  final String reciverId;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.reciverId,
    required this.message,
    required this.senderEmail,
    required this.timestamp,
  });
  //convert to map
  Map<String, dynamic> toMap() => {
        "senderId": senderId,
        "reciverId": reciverId,
        "message": message,
        "timestamp": timestamp,
        "senderEmail": senderEmail
      };
}
