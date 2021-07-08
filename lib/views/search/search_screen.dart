import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/search/search_cubit.dart';
import 'package:tripper_flutter/components/custom_form_field.dart';
import 'package:tripper_flutter/components/favourite_list_item.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: searchController,
                      inputType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' enter text to search';
                        }
                        return null;
                      },
                      labelText: 'Search',
                      prefix: Icons.search,
                      radius: 40,
                      onFieldSubmitted: (String text) {
                        cubit.search(text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) =>
                              FavouriteListItem(cubit.searchModel),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 0,
                          ),
                          //cubit.searchModel.data.data.length
                          itemCount: 2,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
