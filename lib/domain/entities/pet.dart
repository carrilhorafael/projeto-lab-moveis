class Pet {
  String id;
  String name;
  String description;
  String species;
  String race;
  Size size;
  int age;

  Pet({
    required this.id,
    required this.name,
    this.description = "",
    required this.species,
    required this.race,
    required this.size,
    required this.age,
  });
}

enum Size { small, medium, big }
