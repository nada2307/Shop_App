import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.favoritesModel!.data!.data!.length > 0,
            builder: (context) => ConditionalBuilder(
              condition: state is! GetFavoritesLoadingState,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildProductItem(
                    context, cubit.favoritesModel!.data!.data![index].product),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoritesModel!.data!.data!.length,
                physics: const BouncingScrollPhysics(),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 100.0,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Favorites Yet, Please Add Some Favorites',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

