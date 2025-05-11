import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  User? checkUserLogined() {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        return currentUser;
      }
    } catch (e) {
      print("Authentication failed: $e");
      return null;
    }
    return null;
  }

  Future<User?> userAuth(String email, String password) async {
    try {
      User? currentUser = checkUserLogined();
      if (currentUser != null) {
        return currentUser;
      }
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user; // Return the signed-in user
    } catch (e) {
      try {
        UserCredential newUserCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        return newUserCredential.user; // Return the newly created user
      } catch (e) {
        print("Authentication failed: $e");
        return null;
      }
    }
  }

  logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("logout failed: $e");
    }
  }
}
