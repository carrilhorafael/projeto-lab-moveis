import 'dart:convert';

import 'package:projeto_lab/util/enum.dart';

class Pet {
  String id;
  String ownerId;
  String name;
  String description;
  String species;
  String race;
  Size size;
  int age;

  Pet({
    this.id = "",
    required this.ownerId,
    required this.name,
    this.description = "",
    required this.species,
    required this.race,
    required this.size,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'species': species,
      'race': race,
      'size': enumToString(size),
      'age': age,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'] ?? "",
      ownerId: map['ownerId'],
      name: map['name'],
      description: map['description'],
      species: map['species'],
      race: map['race'],
      size: enumFromString(Size.values, map['size']),
      age: map['age'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) => Pet.fromMap(json.decode(source));
}

enum Size { small, medium, big }
