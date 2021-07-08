import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/models/property/property_model.dart';
import 'package:tripper_flutter/src/colors.dart';

class FavouriteListItem extends StatelessWidget {
  final PropertyModel propertyModel;

  FavouriteListItem(this.propertyModel);

  @override
  Widget build(BuildContext context) {
    bool isFav = true;

    if (AppCubit.get(context).favorites[propertyModel.propertyId] == false ||
        AppCubit.get(context).favorites[propertyModel.propertyId] == null) {
      isFav = false;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage('${propertyModel.thumbnail}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .changeFavorites(propertyID: propertyModel.propertyId);
                  },
                  icon: CircleAvatar(
                    radius: 23.0,
                    backgroundColor: isFav ? defaultColor : Colors.grey,
                    child: Icon(
                      Icons.favorite_border_outlined,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${propertyModel.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${propertyModel.description}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${propertyModel.price} / night',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${propertyModel.category}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
