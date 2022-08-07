import 'package:shop_app/models/ChangeFavoritesModel.dart';
import 'package:shop_app/models/loginModel.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppLoadingState extends ShopAppStates {}

class ShopAppChangeBottomNavState extends ShopAppStates {}

class ShopAppHomeDataLoadingState extends ShopAppStates {}

class ShopAppHomeDataSuccessState extends ShopAppStates {}

class ShopAppHomeDataErrorState extends ShopAppStates {
  final String error;

  ShopAppHomeDataErrorState(this.error);
}

class ChangeFavState extends ShopAppStates {}

class GetCategoriesLoadingState extends ShopAppStates {}

class GetCategoriesSuccessState extends ShopAppStates {}

class GetCategoriesErrorState extends ShopAppStates {
  final String error;

  GetCategoriesErrorState(this.error);
}

class GetCategoriesDetailsLoadingState extends ShopAppStates {}

class GetCategoriesDetailsSuccessState extends ShopAppStates {}

class GetCategoriesDetailsErrorState extends ShopAppStates {
  final String error;

  GetCategoriesDetailsErrorState(this.error);
}

class GetFavoritesLoadingState extends ShopAppStates {}

class GetFavoritesSuccessState extends ShopAppStates {}

class GetFavoritesErrorState extends ShopAppStates {
  final String error;

  GetFavoritesErrorState(this.error);
}

class ChangeFavoritesLoadingState extends ShopAppStates {}

class ChangeFavoritesSuccessState extends ShopAppStates {
  final ChangeFavoriteModel model;

  ChangeFavoritesSuccessState(this.model);
}

class ChangeFavoritesErrorState extends ShopAppStates {
  final String error;

  ChangeFavoritesErrorState(this.error);
}

class GetUserDataLoadingState extends ShopAppStates {}

class GetUserDataSuccessState extends ShopAppStates {
  final LoginModel loginModel;

  GetUserDataSuccessState(this.loginModel);
}

class GetUserDataErrorState extends ShopAppStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends ShopAppStates {}

class UpdateUserDataSuccessState extends ShopAppStates {
  final LoginModel loginModel;

  UpdateUserDataSuccessState(this.loginModel);
}

class UpdateUserDataErrorState extends ShopAppStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}

class GetSearchLoadingState extends ShopAppStates {}

class GetSearchSuccessState extends ShopAppStates {}

class GetSearchErrorState extends ShopAppStates {
  final String error;

  GetSearchErrorState(this.error);
}
