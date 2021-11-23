import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';

abstract class InterestService {
  List<Interest> findInterests(User user);

  List<Interest> findInteressed(Pet pet);

  void add(Interest interest);

  void updateStatus(Interest interest, Status newStatus);

  void remove(Interest interestId);
}
