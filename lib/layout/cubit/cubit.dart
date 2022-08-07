import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/ChangeFavoritesModel.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/categoryDetailModel.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/categories/categoriesScreen.dart';
import 'package:shop_app/modules/favorites/favoritiesScreen.dart';
import 'package:shop_app/modules/products/productsScreen.dart';
import 'package:shop_app/modules/setting/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_pionts.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;



  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Faverites',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(ShopAppChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppHomeDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.data!.banners[0].id);
      // print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
        //print(favorites.toString());
      });
      emit(ShopAppHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopAppHomeDataErrorState(error.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFav(int productId) {
    print('hi');
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesLoadingState());
    DioHelper.postData(
            url: FAVORITE,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ChangeFavoritesSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ChangeFavoritesErrorState(error));
    });
  }

  CategoriesModel? categories;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categories = CategoriesModel.fromJson(value.data);

      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesErrorState(error));
    });
  }

  CategoryDetailModel? categoryDetails;

  void getCategoryDetail(int id) {
    DioHelper.getData(url: "categories/$id",
        query: {
          'category_id': '$id',
        }
    ).then((value) {
      categoryDetails = CategoryDetailModel.fromJson(value.data);

      emit(GetCategoriesDetailsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesDetailsErrorState(error));
    });
  }
  FavoriteModel? favoritesModel;

  void getFavorites() {
    emit(GetFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoritesModel = FavoriteModel.fromJson(value.data);
      // print(value.data.toString());

      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesErrorState(error));
    });
  }
////
  LoginModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      // print(value.data.toString());

      emit(GetUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateUserDataLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
 print(value.data.toString());

      emit(UpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState(error));
    });
  }
}
