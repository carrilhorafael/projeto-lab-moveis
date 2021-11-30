import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:faker/faker.dart' hide Address;
import 'package:flutter_test/flutter_test.dart';

import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/exceptions/not_found_exception.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

User validUser() {
  return User(
      name: faker.person.name(),
      address: Address(
          postalCode: faker.randomGenerator.numberOfLength(10),
          address: faker.address.streetName(),
          state: State("Acre", "AC")),
      email: faker.internet.email(),
      phone: faker.phoneNumber.us());
}

Future<void> main() async {
  test("create works...", () async {
    final fake = FakeFirebaseFirestore();
    final service = UserService(fake);

    final user = validUser();
    await service.create(user);
    assert(user.id.length > 0);
  });

  test("find works...", () async {
    // Setup
    final store = FakeFirebaseFirestore();
    var data = validUser();
    final ref = await store.collection("users").add(data.toMap());

    final service = UserService(store);
    final user = await service.find(ref.id);

    // Assertions
    assert(user.name == data.name);

    expect(() async => await service.find("404"),
        throwsA(TypeMatcher<NotFoundException>()));
  });

  test("update works...", () async {
    final store = FakeFirebaseFirestore();
    final service = UserService(store);

    final user = validUser();
    await service.create(user);

    user.name = "A different Name";

    await service.update(user);

    final fromServer = await service.find(user.id);
    expect(user.name, fromServer.name);
  });
}
