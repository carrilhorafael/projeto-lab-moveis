import 'package:projeto_lab/domain/entities/pet.dart';

abstract class PetService {
  void create(Pet pet);

  Pet find(String id);

  void update(Pet pet);

  void delete(String id);

  List<Pet> ownedBy(String userId);
}
