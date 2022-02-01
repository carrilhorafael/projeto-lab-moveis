/// Este Módulo contém `SearchOptions`, que representa as configurações de busca
/// que um usuário interessado em adotar um pet pode definir para filtrar
/// as opções possíveis.

import 'dart:convert';

import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/util/enum.dart';

class SearchOptions {
  double maxAge;

  /// In km
  double maxDistance;

  Set<Size> sizes = {};

  Set<String> races = {};

  /// A species may be dog, cat etc
  Set<String> species = {};

  SearchOptions({required this.maxAge, required this.maxDistance});

  /// Determines if a pet respects the search options.
  bool matches(Pet pet) {
    throw new UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    return {
      'maxAge': maxAge,
      'maxDistance': maxDistance,
      'size': sizes.map((x) => enumToString(x)).toList(),
      'races': races.toList(),
      'species': species.toList(),
    };
  }

  factory SearchOptions.fromMap(Map<String, dynamic> map) {
    final options = SearchOptions(
      maxAge: map['maxAge'],
      maxDistance: map['maxDistance'],
    )
      ..sizes = Set<Size>.from(
          map['size']?.map((x) => enumFromString(Size.values, x)))
      ..races = Set<String>.from(map['races'])
      ..species = Set<String>.from(map['species']);

    return options;
  }

  String toJson() => json.encode(toMap());

  factory SearchOptions.fromJson(String source) =>
      SearchOptions.fromMap(json.decode(source));
}
