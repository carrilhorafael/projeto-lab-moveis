import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/util/enum.dart';

import 'exceptions/not_found_exception.dart';

class InterestService {
  static const collectionName = "interests";

  final FirebaseFirestore store;

  InterestService(this.store);

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
