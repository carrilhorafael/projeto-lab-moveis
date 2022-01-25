import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/user_service.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart'
    as AddressState;
import 'package:projeto_lab/util/geo.dart';

class AuthService {
  final FirebaseAuth auth;
  final UserService userService;
  static User? _currentUser;

  AuthService(this.auth, this.userService) {
    // authListener().listen((loggedIn) {
    //   if (!loggedIn) {
    //     AuthService._currentUser = null;
    //   }
    // });
  }

  Future<void> register(String email, String password, User user) async {
    try {
      UserCredential userCredential = await this
          .auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user.id = userCredential.user!.uid;
      await this.userService.create(user);
      AuthService._currentUser = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          print('The account already exists for that email.');
          break;
        default:
          print("An auth error occurred");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = await userService.find(userCredential.user!.uid);
      AuthService._currentUser = user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
    await _updateCurrentUserPosition();
  }

  Future<void> _updateCurrentUserPosition() async {
    if (_currentUser == null) return;

    final position = await determinePosition();
    _currentUser!.position = position;

    await userService.update(_currentUser!);
  }

  static User? currentUser() {
    return AuthService._currentUser;
  }

  /// The stream returns true if the user is authenticated. False otherwise.
  Stream<bool> authListener() {
    return auth.authStateChanges().map((user) => user != null);
  }
}
