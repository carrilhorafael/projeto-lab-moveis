/// Este Módulo contém `PetSearchService`, um serviço que é responsável por obter
/// pets para serem sugeridos para adoção ao usuário atual, além de salvar e obter
/// as configurações de busca do armazenamento local.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';

class PetSearchService {
  static const optionsKey = "options";
  final FirebaseFirestore store;
  final PetService petService;
  final InterestService interestService;

  PetSearchService(this.store, this.petService, this.interestService);

  // NOTE Should we guarantee that this service only shows a pet once per user?
  Future<List<Pet>> searchMore(SearchOptions options,
      {int maxAmount = 10}) async {
    var query = petService
        .query()
        .limit(maxAmount)
        .where("age", isLessThanOrEqualTo: options.maxAge);

    final whereFields = {
      "size": options.sizes,
      "species": options.species,
      "race": options.races,
    };

    // Other fields
    whereFields.forEach((key, fieldSet) {
      if (fieldSet.isNotEmpty) {
        query = query.where(key, whereIn: fieldSet.toList());
      }
    });

    // Remove pets that have been matched with current user
    final interestedIn = (await interestService.findInterests(AuthService.currentUser()!)).map((i) => i.petId).toList();

    final snapshot = await query.get();
    return snapshot.docs
        .map((e) => e.data())
        .where((p) => p.ownerId != AuthService.currentUser()!.id && !interestedIn.contains(p.id))
        .toList();
  }

  Future<void> save(SearchOptions options) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(optionsKey, options.toJson());
  }

  Future<SearchOptions> retrieve() async {
    final prefs = await SharedPreferences.getInstance();
    final content = prefs.getString(optionsKey);
    if (content == null) {
      return SearchOptions(maxAge: 100, maxDistance: 1000);
    }
    return SearchOptions.fromJson(content);
  }
}
