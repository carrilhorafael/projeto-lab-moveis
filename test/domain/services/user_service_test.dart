import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/exceptions/not_found_exception.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

User validUser() {
  return User(
      name: "Canellas",
      address: Address(
          postalCode: "202020",
          address: "Amaral Peixoto",
          state: State("Acre", "AC")),
      email: "email",
      phone: "adwad");
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
}
