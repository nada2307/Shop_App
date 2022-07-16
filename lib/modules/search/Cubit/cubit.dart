import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/searchModel.dart';
import 'package:shop_app/modules/search/Cubit/states.dart';
import 'package:shop_app/shared/network/end_pionts.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void searchProduct(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
     // print(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error));
    });
  }
}
