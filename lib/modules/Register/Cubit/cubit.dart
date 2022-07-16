import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/Register/Cubit/states.dart';
import 'package:shop_app/shared/network/end_pionts.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';




class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? login;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data: {
          'email' : email,
          'password' : password,
          'name' : name,
          'phone' : phone,
        }).then((value) {
      print(value.data);
      login = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(login!));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPress = true;

  void changePasswordVisibility(){
    isPress = !isPress;
    suffix = isPress? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }


}