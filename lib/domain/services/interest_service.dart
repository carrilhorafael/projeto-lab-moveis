/// Este Módulo contém `InterestService`, um serviço que contém as operações CRUD
/// de um interesse, além de permitir obter os interesses de um pet ou de um usuário.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/util/enum.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'auth_service.dart';
import 'exceptions/not_found_exception.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

class InterestService {
  static const collectionName = "interests";
  final PetService petService;
  final UserService userService;
  final FirebaseFirestore store;

  InterestService(this.store, this.petService, this.userService);

  CollectionReference<Interest> collection() {
    return this.store.collection(collectionName).withConverter(
        fromFirestore: (snapshot, _) {
          if (!snapshot.exists) {
            throw NotFoundException();
          }
          final map = snapshot.data()!;
          map['id'] = snapshot.id;
          return Interest.fromMap(map);
        },
        toFirestore: (interest, _) => interest.toMap());
  }

  Future<List<Interest>> findInterests(User user) async {
    final snapshot =
        await collection().where("userId", isEqualTo: user.id).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<List<Interest>> findInteressed(Pet pet) async {
    final snapshot = await collection().where("petId", isEqualTo: pet.id).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> add(Interest interest) {
    //Adiciona o match no Firebase e notifica o dono do Pet através do OneSignal
    ()async {
      Pet currentPet = await petService.find(interest.petId);
      User ownerPet = await userService.find(currentPet.ownerId);
      User user = await userService.find(interest.userId);

      OneSignal.shared.postNotification(OSCreateNotification(
        androidChannelId: "c589b224-348e-4fad-ad43-21198120a26b",
        playerIds: [ownerPet.playerID],
        content: "Você tem um novo match. ${user.name} curtiu o seu Pet.",
        heading: "Novo Match",


      ));
    }();
    return collection().add(interest);
  }

  Future<Interest> find(String id) async {
    return (await collection().doc(id).get()).data()!;
  }

  Future<void> updateStatus(Interest interest, Status newStatus) async {
    await collection()
        .doc(interest.id)
        .update({'status': enumToString(newStatus)});
    interest.status = newStatus;

  }

  Future<void> remove(String id) {
    return collection().doc(id).delete();
  }
}
