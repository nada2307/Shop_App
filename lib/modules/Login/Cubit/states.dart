import 'package:shop_app/models/loginModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel login;

  LoginSuccessState(this.login);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}

class LoginLoadingState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}

