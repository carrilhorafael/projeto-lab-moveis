import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'location/address.dart';

class User {
  String id;
  String name;
  Address address;
  String email;
  String phone;
  String description;
  String playerID; // For notification
  Position? position;

  User({
    this.id = "",
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.description = "",
    this.playerID = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address.toMap(),
      'email': email,
      'phone': phone,
      'description': description,
      'playerID':playerID,
      'position': position?.toJson(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    final user = User(
      id: map['id'] ?? "",
      name: map['name'],
      address: Address.fromMap(map['address']),
      email: map['email'],
      phone: map['phone'],
      description: map['description'],
      playerID: map['playerID'],
    );
    final position = map['position'];

    if (position != null) {
      user.position = Position.fromMap(position);
    }
    return user;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
