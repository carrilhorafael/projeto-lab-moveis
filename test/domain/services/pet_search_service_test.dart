import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/domain/services/pet_search_service.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pet_service_test.dart';
import 'user_service_test.dart';

Future<void> main() async {
  group("Pet Search Service", () {
    late FakeFirebaseFirestore fake;
    late PetSearchService service;
    late PetService petService;
    late UserService userService;

    setUp(() async {
      fake = FakeFirebaseFirestore();
      userService = UserService(fake);
      petService = PetService(fake, userService);
      service = PetSearchService(fake, petService);

      SharedPreferences.setMockInitialValues({});
    });

    test('save and retrieve', () async {
      (await SharedPreferences.getInstance()).clear();

      // retrieving without saving yields null
      expect(await service.retrieve(), null);

      final options = SearchOptions(maxAge: 10, maxDistance: 20.0);
      await service.save(options);
      final other = (await service.retrieve())!;

      expect(other.maxAge, options.maxAge);
      expect(other.maxDistance, options.maxDistance);
      assert(other.sizes.isEmpty);
    });

    // NOTE `searchMore` should have tests for fields like `size`, `race`...
    test("searchMore", () async {
      final options = SearchOptions(maxAge: 5, maxDistance: 10.0);

      // Not pets should be retrieved if there's no one saved.
      final noPets = await service.searchMore(options);
      expect(noPets, []);

      // Setup pets for further assertions
      final user = validUser();
      await userService.create(user);
      final random = Random(1);

      final list = List.generate(10, (_) async {
        final pet = await validPet(user);
        pet.age = random.nextInt(10);
        petService.create(pet);
        return pet;
      });

      final inserted = await Future.wait(list);
      final searched = await service.searchMore(options);

      final expectedAmount =
          inserted.where((element) => element.age <= options.maxAge).length;

      expect(searched.length, expectedAmount);

      for (final pet in searched) {
        assert(pet.age <= options.maxAge);
      }
    });
  });
}
