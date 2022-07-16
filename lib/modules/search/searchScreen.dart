import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/favorites/favoritiesScreen.dart';
import 'package:shop_app/modules/search/Cubit/cubit.dart';
import 'package:shop_app/modules/search/Cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SearchCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return "Enter text to search";
                            }
                          },
                          label: "Search",
                          prefix: Icons.search,
                          onSubmit: (String text) {
                            if (formKey.currentState!.validate())
                              cubit.searchProduct(text);
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildProductItem(
                              context,
                              cubit.model!.data!.data![index],
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.model!.data!.data!.length,
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
