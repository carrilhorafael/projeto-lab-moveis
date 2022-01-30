import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

import 'pet_service_test.dart';
import 'user_service_test.dart';

Future<void> main() async {
  group("Interest Service", () {
    late FakeFirebaseFirestore store;
    late InterestService service;
    late UserService userService;
    late PetService petService;
    late User user;
    late Pet pet;

    setUp(() async {
      store = FakeFirebaseFirestore();
      userService = UserService(store);
      petService = PetService(store, userService);
      service = InterestService(store, petService, userService);

      user = validUser();
      await userService.create(user);
      pet = await validPet(user);
      await petService.create(pet);
    });

    test("use cases", () async {
      final anotherPet = await validPet(user);
      // Creation
      await service.add(Interest(userId: user.id, petId: pet.id));
      await service.add(Interest(userId: user.id, petId: anotherPet.id));

      // findInterests
      var userInterests = await service.findInterests(user);
      expect(userInterests.length, 2);
      final firstRetrieved = userInterests[0];
      expect(firstRetrieved.petId, pet.id);

      // findInteressed
      var petInterests = await service.findInteressed(pet);
      expect(petInterests.length, 1);
      expect(petInterests[0].userId, user.id);

      // updateStatus
      await service.updateStatus(firstRetrieved, Status.refused);
      final updated = await service.find(firstRetrieved.id);
      expect(updated.status, firstRetrieved.status);

      // removal
      await service.remove(userInterests[0].id);
      userInterests = await service.findInterests(user);
      expect(userInterests.length, 1);
      expect(userInterests[0].petId, anotherPet.id);
    });
  });
}
