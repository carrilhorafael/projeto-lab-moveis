import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/message.dart';

// NOTE this service will probably change after we start implementing the chat itself

abstract class ChatService {
  List<Message> messages(Interest interest);

  void send(Message message);
}
