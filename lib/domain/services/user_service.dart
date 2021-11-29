import 'package:projeto_lab/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore store;

  UserService(this.store);

  Future<void> create(User user) {
    var users = this.store.collection("users");
    return users.add(user.toMap()).then((value) => {user.id = value.id});
  }

  User find(String id) {
    throw new UnimplementedError();
  }

  void update(User user) {
    throw new UnimplementedError();
  }

  void delete(String id) {
    throw new UnimplementedError();
  }
}
