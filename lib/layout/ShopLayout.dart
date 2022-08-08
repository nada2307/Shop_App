import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Login/loginScreen.dart';
import 'package:shop_app/modules/search/searchScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

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
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: [
              Icons.home_outlined,
              Icons.category_outlined,
              Icons.favorite_border_outlined,
              Icons.settings_outlined,
            ],
            onTap: (index){
            cubit.changeBottomNavBar(index);
            },
            inactiveColor: Colors.grey,
            activeColor: mainColor,
            activeIndex: cubit.currentIndex,
            iconSize: 30.0,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
print(token);

            },
            child: const Icon(
            Icons.shopping_cart_outlined,
            ),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
