import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';

abstract class PetSearchService {
  // NOTE Should we guarantee that this service only shows the same pet only once?
  List<Pet> searchMore(SearchOptions options, {int maxAmount = 10});

  void save(SearchOptions options);

  SearchOptions retrieve();
}
