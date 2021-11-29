import 'dart:convert';

import 'location/address.dart';

class User {
  String id;
  String name;
  Address address;
  String email;
  String phone;
  String description;

  User({
    this.id = "",
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.description = "",
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != "") 'id': id,
      'name': name,
      'address': address.toMap(),
      'email': email,
      'phone': phone,
      'description': description,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? "",
      name: map['name'],
      address: Address.fromMap(map['address']),
      email: map['email'],
      phone: map['phone'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
