import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/domain/services/chat_service.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';
import 'package:projeto_lab/domain/services/pet_search_service.dart';
import 'package:projeto_lab/domain/services/pet_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';

final _store = () => FirebaseFirestore.instance;

final userServiceProvider = Provider((ref) {
  return UserService(_store());
});

final petServiceProvider = Provider((ref) {
  final userService = ref.watch(userServiceProvider);
  return PetService(_store(), userService);
});

final petSearchServiceProvider = Provider((ref) {
  final petService = ref.watch(petServiceProvider);
  return PetSearchService(_store(), petService);
});

final interestServiceProvider = Provider((ref) {
  final petService = ref.watch(petServiceProvider);
  final userService = ref.watch(userServiceProvider);
  return InterestService(_store(), petService, userService);
});

final authServiceProvider = Provider((ref) {
  final userService = ref.watch(userServiceProvider);
  return AuthService(FirebaseAuth.instance, userService);
});

final chatServiceProvider = Provider((ref) {
  final interestService = ref.watch(interestServiceProvider);
  final petService = ref.watch(petServiceProvider);
  final userService = ref.watch(userServiceProvider);
  return ChatService(interestService, petService, userService);
});
