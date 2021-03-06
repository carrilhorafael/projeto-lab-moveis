/// Este Módulo contém `State`, que representa um estado do Brasil. Apenas
/// estados válidos podem ser representados.

import 'dart:convert';

class State {
  final String name;
  final String abbreviation;

  State(this.name, this.abbreviation) {
    final isValid = validStates.any((element) =>
        element.abbreviation == abbreviation && element.name == name);

    if (!isValid) {
      throw new ArgumentError("($name, $abbreviation) is not a valid state");
    }
  }

  const State._(this.name, this.abbreviation);

  static const validStates = [
    State._("Acre", "AC"),
    State._("Alagoas", "AL"),
    State._("Amapá", "AP"),
    State._("Amazonas", "AM"),
    State._("Bahia", "BA"),
    State._("Ceará", "CE"),
    State._("Distrito Federal", "DF"),
    State._("Espírito Santo", "ES"),
    State._("Goiás", "GO"),
    State._("Maranhão", "MA"),
    State._("Mato Grosso", "MT"),
    State._("Mato Grosso do Sul", "MS"),
    State._("Minas Gerais", "MG"),
    State._("Pará", "PA"),
    State._("Paraíba", "PB"),
    State._("Paraná", "PR"),
    State._("Pernambuco", "PE"),
    State._("Piauí", "PI"),
    State._("Rio de Janeiro", "RJ"),
    State._("Rio Grande do Norte", "RN"),
    State._("Rio Grande do Sul", "RS"),
    State._("Rondônia", "RO"),
    State._("Roraima", "RR"),
    State._("Santa Catarina", "SC"),
    State._("São Paulo", "SP"),
    State._("Sergipe", "SE"),
    State._("Tocantins", "TO")
  ];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbreviation': abbreviation,
    };
  }

  factory State.fromMap(Map<String, dynamic> map) {
    return State._(
      map['name'],
      map['abbreviation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory State.fromJson(String source) => State.fromMap(json.decode(source));
}
