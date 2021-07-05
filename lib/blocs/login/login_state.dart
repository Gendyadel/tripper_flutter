part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class GoogleLoginLoadingState extends LoginState {}

class GoogleLoginSuccessState extends LoginState {
  // final String uId;
  //
  // GoogleLoginSuccessState(this.uId);
}

class GoogleLoginErrorState extends LoginState {
  final String error;

  GoogleLoginErrorState(this.error);
}

class PasswordChangeVisibilityState extends LoginState {}
