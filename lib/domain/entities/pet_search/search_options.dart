import 'package:projeto_lab/domain/entities/pet.dart';

class SearchOptions {
  int maxAge;

  /// In km
  double maxDistance;

  Set<Size> size = {};

  Set<String> races = {};

  /// A species may be dog, cat etc
  Set<String> species = {};

  SearchOptions({required this.maxAge, required this.maxDistance});

  /// Determines if a pet respects the search options.
  bool matches(Pet pet) {
    throw new UnimplementedError();
  }
}
