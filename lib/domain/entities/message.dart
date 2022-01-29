import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/user.dart';

class Message {
  String interestId;
  String senderId = "";
  String content;
  Timestamp? createdAt;

  Message({
    required this.interestId,
    required this.content,
  });

  bool isFrom(User user) {
    return senderId == user.id;
  }

  Map<String, dynamic> toMap() {
    return {
      'interestId': interestId,
      'senderId': senderId,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    final message = Message(
      interestId: map['interestId'] ?? '',
      content: map['content'] ?? '',
    );
    message.senderId = map['senderId'] ?? '';
    message.createdAt = map['createdAt'];

    return message;
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
