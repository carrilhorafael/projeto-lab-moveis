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
            fromFirestore: (snapshot, _) {
              if (!snapshot.exists) {
                throw NotFoundException();
              }
              return Pet.fromMap(snapshot.data()!);
            },
            toFirestore: (pet, _) => pet.toMap());
  }

  Future<Pet> find(String id) {
    throw UnimplementedError();
  }

  Future<void> update(Pet pet) {
    throw UnimplementedError();
  }

  Future<void> delete(String id) {
    throw UnimplementedError();
  }

  Future<List<Pet>> ownedBy(String userId) {
    throw UnimplementedError();
  }
}
