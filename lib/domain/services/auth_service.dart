import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/user_service.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart'
    as AddressState;

class AuthService {
  final FirebaseAuth auth;
  final UserService userService;
  static User _currentUser = User(
        id: "0",
        name: "João da Silva",
        address: Address(
          postalCode: "20111-111",
          address: "Rua 1, Icaraí, Niterói",
          complement: "Ap 101",
          state: AddressState.State("Rio de Janeiro", "RJ")
        ),
        email: "joao@dasilva.com",
        phone: "2199999-9999",
        description:
          "Lorem ipsum amet dolor Lorem ipsum amet dolor Lorem ipsum amet dolor"
      );

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
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static User currentUser() {
    return AuthService._currentUser;
  }

  /// The stream returns true if the user is authenticated. False otherwise.
  Stream<bool> authListener() {
    return auth.authStateChanges().map((user) => user != null);
  }
}
