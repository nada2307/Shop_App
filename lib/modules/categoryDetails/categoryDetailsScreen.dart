import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: ConditionalBuilder(
              condition: cubit.categoryDetails!.data.productData.isNotEmpty ,
              builder: (context) => ConditionalBuilder(
                condition: state is! GetCategoriesDetailsLoadingState,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildProductItem(
                      context, cubit.categoryDetails!.data.productData[index]),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: cubit.categoryDetails!.data.productData.length,
                  physics: const BouncingScrollPhysics(),
                ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
