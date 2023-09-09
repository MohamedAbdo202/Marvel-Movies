import 'package:bloc/bloc.dart';
import '../../domain/usecases/LoginUseCase.dart';
import 'Stats.dart';

class AuthCubit extends Cubit<LoginState> {
  final SignInWithEmailAndPassword loginUseCase;
  final RegisterWithEmailAndPassword registerWithEmailAndPassword;

  AuthCubit({required this.loginUseCase, required this.registerWithEmailAndPassword})
      : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(LoginLoadingSuccess());

      final user = await loginUseCase(email, password);
      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Login failed. Please check your credentials.')); // Use LoginFailure
      }
    } catch (e) {
      // Specific error handling based on exceptions
        emit(LoginFailure('An error occurred during login. Please try again.')); // Use LoginFailure


      print('Error during login: $e');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final user = await registerWithEmailAndPassword(name, email, password);
      if (user != null) {
        emit(RegistrationSuccess());
      } else {
        emit(RegistrationFailure('Registration failed. Please try again.'));
      }
    } catch (e) {
      // Specific error handling based on exceptions
        emit(RegistrationFailure('An error occurred during registration. Please try again.')); // Use RegistrationFailure


      //
      print('Error during registration: $e');
    }
  }
}
