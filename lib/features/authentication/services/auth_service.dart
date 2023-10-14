import 'package:brick_breaker/features/authentication/models/user_model.dart';
import 'package:brick_breaker/features/authentication/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future _populateCurrentUser(User user) async {
    _currentUser = await _firestoreService.getUser(user.uid);
  }

  Future signUpWithEmail(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
          id: authResult.user!.uid.toString(),
          email: authResult.user!.email.toString(),
          userName: userName);

      await _firestoreService.createUser(user);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await _populateCurrentUser(authResult.user!);
      return authResult.user != null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
