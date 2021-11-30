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
    user.id = snapshot.id;

    return user;
  }

  CollectionReference<User> _collection() {
    return this.store.collection(collectionName).withConverter<User>(
        fromFirestore: (snapshot, _) {
          if (!snapshot.exists) {
            throw NotFoundException();
          }
          return User.fromMap(snapshot.data()!);
        },
        toFirestore: (user, _) => user.toMap());
  }

  Future<DocumentSnapshot<User>> _fetchSnapshot(String id) async {
    return await _collection().doc(id).get();
  }

  void delete(String id) {
    throw new UnimplementedError();
  }
}
