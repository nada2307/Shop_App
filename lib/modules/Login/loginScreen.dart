import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/modules/Login/Cubit/cubit.dart';
import 'package:shop_app/modules/Login/Cubit/states.dart';
import 'package:shop_app/modules/Register/registerScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.login.status!) {
              print(state.login.message);
              print(state.login.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.login.data!.token,
              ).then((value) {
                token = state.login.data!.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.login.message);
              showToast(
                text: state.login.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            }
                          },
                          label: "Email",
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          isPassword: LoginCubit.get(context).isPress,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Password is too short";
                            }
                          },
                          label: "Password",
                          prefix: Icons.lock_outline_rounded,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                navigateAndFinish(context, ShopLayout());
                              }
                            },
                            text: "login",
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don\'t have an acount ?",
                            ),
                            defultTextBottom(
                              onPressed: () {
                                navigateAndFinish(
                                  context,
                                  RegisterScreen(),
                                );
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
