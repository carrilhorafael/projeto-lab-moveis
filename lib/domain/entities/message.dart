import 'package:projeto_lab/domain/entities/user.dart';

class Message {
  String interestId;
  String senderId = "";
  String content;

  Message({
    required this.interestId,
    required this.content,
  });

  bool isFrom(User user) {
    return senderId == user.id;
  }
}
