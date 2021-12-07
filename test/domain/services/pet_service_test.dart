import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/exceptions/not_found_exception.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

import 'user_service_test.dart';

Future<Pet> validPet(User user) async {
  return Pet(
      age: int.parse(faker.randomGenerator.numberOfLength(2)),
      name: faker.person.name(),
      race: faker.lorem.word(),
      size: Size.small,
      species: faker.lorem.word(),
      ownerId: user.id);
}

Future<void> main() async {
  group("Pet Service", () {
    late FakeFirebaseFirestore fake;

    late UserService userService;
    late User user;

    late PetService petService;
    late Pet pet;

    setUp(() async {
      fake = FakeFirebaseFirestore();

      userService = UserService(fake);
      user = validUser();
      await userService.create(user);

      petService = PetService(fake, userService);
      pet = await validPet(user);
    });

    test("create", () async {
      await petService.create(pet);
      assert(pet.id != "");
      assert(pet.ownerId == user.id);
    });

    test("find", () async {
      await petService.create(pet);

      final anotherPet = await petService.find(pet.id);
      expect(anotherPet.id, pet.id);

      expect(() async => await petService.find("404"),
          throwsA(isA<NotFoundException>()));
    });

    test("update", () async {
      await petService.create(pet);

      pet.name = "Another name";
      pet.age = 2;

      await petService.update(pet);

      final anotherRef = await petService.find(pet.id);

      // fields that changed
      expect(anotherRef.name, pet.name);
      expect(anotherRef.age, pet.age);

      // another field which hasn't changed
      expect(anotherRef.species, pet.species);
    });

    test("delete", () async {
      await petService.create(pet);

      await petService.delete(pet.id);

      // We shouldn't be able to retrieve the record after being deleted
      expect(() async => await petService.find(pet.id),
          throwsA(isA<NotFoundException>()));

      // Deletion of an invalid id should work fine.
      await petService.delete("404");
    });
  });
}
