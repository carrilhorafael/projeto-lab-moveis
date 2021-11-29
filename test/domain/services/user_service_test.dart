import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

Future<void> main() async {
  test("Should work...", () async {
    final user = User(
        name: "Canellas",
        address: Address(
            postalCode: "202020",
            address: "Amaral Peixoto",
            state: State("Acre", "AC")),
        email: "email",
        phone: "adwad");

    final fake = FakeFirebaseFirestore();
    final service = UserService(fake);

    await service.create(user);
    assert(user.id.length > 0);
  });
}
