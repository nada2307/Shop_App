import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  //var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) {
              var model = cubit.userModel;
              emailController.text = model!.data!.email!;
              nameController.text = model.data!.name!;
              phoneController.text = model.data!.phone!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(state is UpdateUserDataLoadingState)
                        const LinearProgressIndicator(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your name";
                            }
                          },
                          label: "User Name",
                          prefix: Icons.person_outline_outlined,
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
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.number,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your phone";
                            }
                          },
                          label: "Phone",
                          prefix: Icons.phone_outlined,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(
                          text: 'UPDATE',
                          function: () {
                            if(formKey.currentState!.validate()) {
                              cubit.updateUserData(name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,);
                            }
                            },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                          text: 'LOGOUT',
                          function: () {
                            SinOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback: (context) =>
            const Center(child: CircularProgressIndicator()),
          );
        });

    /*Center(
      child:
    );*/
  }
}
