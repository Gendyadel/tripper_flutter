import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_text.dart';
import 'package:tripper_flutter/components/favourite_list_item.dart';
import 'package:tripper_flutter/models/property/property_model.dart';
import 'package:tripper_flutter/src/colors.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<PropertyModel> propertyModel = cubit.favouriteModel;

        return Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Wishlist',
                ),
                SizedBox(
                  height: 5,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      FavouriteListItem(propertyModel[index]),
                  separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 0,
                  ),
                  itemCount: propertyModel.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
