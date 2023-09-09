import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_task/Features/Auth/data/models/usermodel.dart';

abstract class AuthRemote {
  Future<UserModel?> signInWithEmailAndPassword(String email, String password);
  Future<UserModel?> registerWithEmailAndPassword(String name, String email, String password);
}

class AuthImplWithFirebase implements AuthRemote {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel?> registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



      // Create and return a UserModel based on the registered user's information
      return UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );
    } catch (e) {
      // Handle registration error
      print("Error registering: $e");
      return null;
    }
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create and return a UserModel based on the signed-in user's information
      return UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        email: email,
      );
    } catch (e) {
      print("Error signing in: $e");
      return null;
    }
  }
}
