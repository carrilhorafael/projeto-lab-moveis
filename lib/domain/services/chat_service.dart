import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/message.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';

import 'exceptions/not_found_exception.dart';

class ChatService {
  final InterestService interestService;
  ChatService(this.interestService);

  CollectionReference<Message> collection(String interestId) {
    return interestService
        .collection()
        .doc(interestId)
        .collection("messages")
        .withConverter(
            fromFirestore: (snapshot, _) {
              if (!snapshot.exists) {
                throw NotFoundException();
              }
              final map = snapshot.data()!;
              map['id'] = snapshot.id;
              return Message.fromMap(map);
            },
            toFirestore: (message, _) => message.toMap());
  }

  Future<Message> lastMessage(Interest interest) async {
    final query = collection(interest.id).orderBy("createdAt");
    final messages = await query.get();

    return messages.docs.map((e) => e.data()).toList().last;
  }

  /// `listener` receives new messages. Useful e.g. to update state after receiving a new message.
  Future<List<Message>> messages(
      Interest interest, Function(Message) listener) async {
    final query = collection(interest.id).orderBy("createdAt");

    final messages = await query.get();

    query.limit(1).snapshots().listen((event) {
      listener(event.docChanges.first.doc.data()!);
    });

    return messages.docs.map((e) => e.data()).toList();
  }

  Future<void> send(Message message) {
    return collection(message.interestId).add(message);
  }
}
