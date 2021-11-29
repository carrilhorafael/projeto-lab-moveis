import 'package:projeto_lab/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exceptions/not_found_exception.dart';

class UserService {
  final FirebaseFirestore store;

  UserService(this.store);

  Future<void> create(User user) {
    var users = this.store.collection("users");
    return users.add(user.toMap()).then((value) => {user.id = value.id});
  }

  Future<User> find(String id) async {
    final snapshot = await this.store.collection("users").doc(id).get();
    if (!snapshot.exists) {
      throw NotFoundException();
    }
    final user = User.fromMap(snapshot.data()!);
    user.id = id;
    return user;
  }

  void update(User user) {
    throw new UnimplementedError();
  }

  void delete(String id) {
    throw new UnimplementedError();
  }
}
