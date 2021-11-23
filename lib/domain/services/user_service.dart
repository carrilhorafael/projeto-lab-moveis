import 'package:projeto_lab/domain/entities/user.dart';

abstract class UserService {
  void create(User user);

  User find(String id);

  void update(User user);

  void delete(String id);
}
