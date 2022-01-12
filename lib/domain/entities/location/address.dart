import 'dart:convert';

import 'state.dart';

class Address {
  /// AKA CEP in Brazil
  String postalCode;
  String address;
  String complement;
  State state;

  Address({
    required this.postalCode,
    required this.address,
    this.complement = "",
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'postalCode': postalCode,
      'address': address,
      'complement': complement,
      'state': state.toMap(),
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      postalCode: map['postalCode'],
      address: map['address'],
      complement: map['complement'],
      state: State.fromMap(map['state']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));
}
