import 'package:shop_app/models/loginModel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}
class ChangeRegisterPasswordVisibility extends RegisterStates {}

class NewsBottomNavState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel login;

  RegisterSuccessState(this.login);
}

class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class NewsGetSportsLoadingState extends RegisterStates {}

class NewsGetSportsSuccessState extends RegisterStates {}

class NewsGetSportsErrorState extends RegisterStates
{
  final String error;

  NewsGetSportsErrorState(this.error);
}
