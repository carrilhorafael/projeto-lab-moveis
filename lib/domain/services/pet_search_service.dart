import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetSearchService {
  static const optionsKey = "options";
  final FirebaseFirestore store;
  final PetService petService;

  PetSearchService(this.store, this.petService);

  // NOTE Should we guarantee that this service only shows a pet once per user?
  Future<List<Pet>> searchMore(SearchOptions options,
      {int maxAmount = 10}) async {
    // TODO filter by distance!
    var query = petService
        .query()
        .limit(maxAmount)
        .where("age", isLessThanOrEqualTo: options.maxAge);

    final whereFields = {
      "size": options.sizes,
      "species": options.species,
      "race": options.races,
    };

    whereFields.forEach((key, fieldSet) {
      if (fieldSet.isNotEmpty) {
        query = query.where(key, whereIn: fieldSet.toList());
      }
    });

    final snapshot = await query.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> save(SearchOptions options) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(optionsKey, options.toJson());
  }

  Future<SearchOptions> retrieve() async {
    final prefs = await SharedPreferences.getInstance();
    final content = prefs.getString(optionsKey);
    if (content == null) {
      return SearchOptions(maxAge: 999, maxDistance: 1000);
    }
    return SearchOptions.fromJson(content);
  }
}
