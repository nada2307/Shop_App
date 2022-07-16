import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessState) {
          if (!state.model.status) {
            showToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categories != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel, context, cubit.categories),
          fallback: (context) => const Center(child:  CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productsBuilder(
        HomeModel? model, context, CategoriesModel? categoriesModel) =>
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                //aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                //enlargeCenterPage: true,

                scrollDirection: Axis.horizontal,
              )),
          const SizedBox(
            height: 7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 23.0,
                    color: mainColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          categoriesItem(categoriesModel!.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoriesModel!.data!.data.length),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 23.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.67,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) => productsItem(model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );

Widget productsItem(ProductsModel model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                positionedFill("Sale"),
               /* Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 7.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),*/
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(color: mainColor, fontSize: 12.0),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).changeFav(model.id);
                      },
                      color: ShopAppCubit.get(context).favorites[model.id]!
                          ? Colors.red
                          : Colors.grey,
                      // iconSize: 10.0,
                      icon: Icon(
                        ShopAppCubit.get(context).favorites[model.id]!
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget categoriesItem(DataModel? model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model!.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
