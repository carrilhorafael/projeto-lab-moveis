import 'package:projeto_lab/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exceptions/not_found_exception.dart';

class UserService {
  static const collectionName = "users";
  final FirebaseFirestore store;

  UserService(this.store);

  Future<void> create(User user) {
    var users = this.store.collection(collectionName);
    return users.add(user.toMap()).then((value) => {user.id = value.id});
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
}
