import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Login/loginScreen.dart';
import 'package:shop_app/modules/search/searchScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(

      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                AppCubit.get(context).changeAppMode();
              },
              icon: Icon(Icons.dark_mode_outlined),
            ),
            title: Text(
              'Salla',
            ),
            actions: [IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search,), )],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(items: cubit.bottomItems,
            onTap: (index){
            cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,


          ),
        );
      },
    );
  }
}
