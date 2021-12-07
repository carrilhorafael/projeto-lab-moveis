import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

import 'exceptions/not_found_exception.dart';

class PetService {
  static const String collectionName = "pets";

  final FirebaseFirestore store;
  final UserService userService;

  PetService(this.store, this.userService);

  Future<void> create(Pet pet) async {
    final docRef = await collection(pet.ownerId).add(pet);
    pet.id = docRef.id;
  }

  CollectionReference<Pet> collection(String ownerId) {
    return userService
        .collection()
        .doc(ownerId)
        .collection(collectionName)
        .withConverter<Pet>(
            fromFirestore: _fromFirestore, toFirestore: _toFirestore);
  }

  Pet _fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    if (!snapshot.exists) {
      throw NotFoundException();
    }
    final map = snapshot.data()!;
    map['id'] = snapshot.id;
    return Pet.fromMap(map);
  }

  Map<String, Object?> _toFirestore(Pet pet, SetOptions? options) {
    return pet.toMap();
  }

  Future<Pet> find(String id) async {
    final snapshot =
        await _query().where(FieldPath.documentId, isEqualTo: id).get();

    if (snapshot.docs.isEmpty) {
      throw NotFoundException();
    } else {
      return snapshot.docs.first.data();
    }
  }

  Future<void> update(Pet pet) async {
    final snapshot = await collection(pet.ownerId).doc(pet.id).get();
    await snapshot.reference.update(pet.toMap());
  }

  Query<Pet> _query() {
    return store.collectionGroup(collectionName).withConverter(
        fromFirestore: _fromFirestore, toFirestore: _toFirestore);
  }

  Future<void> delete(String id) async {
    final snapshot =
        await _query().where(FieldPath.documentId, isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();
    }
  }

  Future<List<Pet>> ownedBy(String userId) async {
    final snapshot = await collection(userId).get();

    return snapshot.docs.map((e) => e.data()).toList();
  }
}
