import 'package:shop_app/models/loginModel.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {
  final String error;

  SearchErrorState(this.error);
}

//
class NewsGetSportsLoadingState extends SearchStates {}

class NewsGetSportsSuccessState extends SearchStates {}

class NewsGetSportsErrorState extends SearchStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}
