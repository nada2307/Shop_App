// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules//Login/loginScreen.dart';
import 'package:shop_app/modules/Login/Cubit/cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'modules/onBoarding_screen.dart';
import 'shared/cubit/cubit.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
        () {
          LoginCubit();
          ShopAppCubit()..getHomeData();
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
 //
  isDark =false;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  //print(onBoarding);

  Widget startScreen;
  if (onBoarding != null) {
    if (token != null) {
      startScreen = ShopLayout();
    } else {
      startScreen = LoginScreen();
    }
  } else {
    startScreen = OnBoardingScreen();
  }

  runApp(MyApp(isDark, startScreen));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startScreen;

  MyApp(this.isDark, this.startScreen);

  // Color n = const Color(0XFF673AB7) ;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopAppCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startScreen,
          );
        },
      ),
    );
  }
}
