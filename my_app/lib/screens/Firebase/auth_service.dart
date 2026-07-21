import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------------------------------
  // Register
  //------------------------------------------------------

  Future<User?> register({
    required String email,

    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,

        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  //------------------------------------------------------
  // Login
  //------------------------------------------------------

  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,

        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {

  print("==================================");
  print("Firebase Error Code : ${e.code}");
  print("Firebase Message    : ${e.message}");
  print("==================================");

  rethrow;

}
  }

  //------------------------------------------------------
  // Logout
  //------------------------------------------------------

  Future<void> logout() async {
    await _auth.signOut();
  }

  //------------------------------------------------------
  // Current User
  //------------------------------------------------------

  User? get currentUser {
    return _auth.currentUser;
  }
}
