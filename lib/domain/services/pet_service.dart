import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/pet.dart';

class PetService {
  final FirebaseFirestore store;

  PetService(this.store);

  Future<void> create(Pet pet) {
    throw UnimplementedError();
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
