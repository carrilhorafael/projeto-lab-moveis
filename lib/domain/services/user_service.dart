/// Este Módulo contém `UserService`, um serviço que oferece as operações CRUD para usuários,
/// além da obtenção de sua imagem de perfil.

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exceptions/not_found_exception.dart';

class UserService {
  static const collectionName = "users";
  final FirebaseFirestore store;

  UserService(this.store);

  Future<void> create(User user) async {
    if (user.id == "") {
      final docRef = await collection().add(user);
      user.id = docRef.id;
    } else {
      await collection().doc(user.id).set(user);
    }
  }

  Future<User> find(String id) async {
    final snapshot = await _fetchSnapshot(id);
    final user = snapshot.data()!;
    return user;
  }

  CollectionReference<User> collection() {
    return this.store.collection(collectionName).withConverter<User>(
        fromFirestore: (snapshot, _) {
          if (!snapshot.exists) {
            throw NotFoundException();
          }
          final map = snapshot.data()!;
          map['id'] = snapshot.id;
          return User.fromMap(map);
        },
        toFirestore: (user, _) => user.toMap());
  }

  Future<DocumentSnapshot<User>> _fetchSnapshot(String id) async {
    return await collection().doc(id).get();
  }

  Future<void> update(User user) async {
    final snapshot = await _fetchSnapshot(user.id);
    await snapshot.reference.update(user.toMap());
  }

  Future<void> delete(String id) {
    return collection().doc(id).delete();
  }

  Reference _userImage(String id) {
    return FirebaseStorage.instance.ref('user_images').child('/$id.png');
  }

  Future<String> uploadImage(String id, File file) async {
    final result = await _userImage(id).putFile(file);
    return result.ref.getDownloadURL();
  }

  Future<String> fetchImageURL(String id) {
    return _userImage(id).getDownloadURL();
  }
}
