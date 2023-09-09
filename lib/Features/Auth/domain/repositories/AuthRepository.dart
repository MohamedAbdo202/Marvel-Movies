import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthRepository {



  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> registerWithEmailAndPassword(String name, String email, String password);
}
