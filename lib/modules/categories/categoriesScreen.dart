import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/modules/categoryDetails/categoryDetailsScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildCat(cubit.categories!.data!.data[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categories!.data!.data.length,
            physics: const BouncingScrollPhysics(),
          );
        });
  }
}

Widget buildCat(DataModel model, context) => Padding(
      padding: const EdgeInsets.all( 15.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              model.image,
            ),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: mainColor,
            ),
            onPressed: () {
              ShopAppCubit.get(context).getCategoryDetail(model.id);
              navigateTo(context, CategoryDetails());

            },
          ),
        ],
      ),
    );
