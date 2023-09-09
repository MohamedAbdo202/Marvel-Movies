import '../../domain/entites/User.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {

}
class LoginLoadingSuccess extends LoginState {

}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

class RegistrationLoading extends LoginState {}

class RegistrationSuccess extends LoginState {

}

class RegistrationFailure extends LoginState {
  final String error;

  RegistrationFailure(this.error);
}
