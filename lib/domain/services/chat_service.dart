import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/message.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';
import 'exceptions/not_found_exception.dart';

class ChatService {
  final InterestService interestService;
  final PetService petService;
  final UserService userService;
  ChatService(this.interestService, this.petService, this.userService);

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

    collection(interest.id)
        .orderBy("createdAt", descending: true)
        .limit(1)
        .snapshots()
        // this `skip` is used to not duplicate the last message on the first load
        .skip(1)
        .listen((event) {
      listener(event.docs.first.data());
    });

    return messages.docs.map((e) => e.data()).toList();
  }

  Future<void> send(Message message) {
        ()async {

      Interest interest = await interestService.find(message.interestId);
      User otherUser = await userService.find(message.senderId);
      if (interest.userId == message.senderId){
        Pet pet = await petService.find(interest.petId);
        User petOwner = await userService.find(pet.ownerId);


        OneSignal.shared.postNotification(OSCreateNotification(
          androidChannelId: "c589b224-348e-4fad-ad43-21198120a26b",

          playerIds: [petOwner.playerID],
          content: "${otherUser.name}: ${message.content}",
          heading: "Nova mensagem",


        ));
      }else{
        User userInterest = await userService.find(interest.userId);
        OneSignal.shared.postNotification(OSCreateNotification(
          androidChannelId: "c589b224-348e-4fad-ad43-21198120a26b",
          playerIds: [userInterest.playerID],
          content: "${otherUser.name}:  ${message.content}",
          heading: "Nova mensagem",

        ));


      }

    }();
    return collection(message.interestId).add(message);
  }
}
