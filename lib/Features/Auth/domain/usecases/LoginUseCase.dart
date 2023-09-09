import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/AuthRepository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository _authRepository;

  SignInWithEmailAndPassword(this._authRepository);

  Future<User?> call(String email, String password) {
    return _authRepository.signInWithEmailAndPassword(email, password);
  }
}

class RegisterWithEmailAndPassword {
  final AuthRepository _authRepository;

  RegisterWithEmailAndPassword(this._authRepository);

  Future<User?> call(String name, String email, String password) {
    return _authRepository.registerWithEmailAndPassword(name, email, password);
  }
}
