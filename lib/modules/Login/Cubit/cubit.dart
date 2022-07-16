import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/Login/Cubit/states.dart';
import 'package:shop_app/shared/network/end_pionts.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';



class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? login;
  void userLogin({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN,
       data: {
      'email' : email,
      'password' : password,
       }).then((value) {
         print(value.data);
       login = LoginModel.fromJson(value.data);
         emit(LoginSuccessState(login!));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }
  
  IconData suffix = Icons.visibility_outlined;
  bool isPress = true;

  void changePasswordVisibility(){
    isPress = !isPress;
    suffix = isPress? Icons.visibility_outlined: Icons.visibility_off_outlined;
emit(ChangePasswordVisibilityState());
  }

}