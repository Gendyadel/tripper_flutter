import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_text.dart';
import 'package:tripper_flutter/models/banner_model.dart';
import 'package:tripper_flutter/models/property/property_model.dart';
import 'package:tripper_flutter/src/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<PropertyModel> propertyModel = cubit.propertyModel;
        List<BannerModel> bannerModel = cubit.bannerModel;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Find nearby places',
              ),
              CarouselSlider(
                items: bannerModel
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: NetworkImage('${e.image}'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 220.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  viewportFraction: 1,
                ),
              ),
              CustomText(
                text: 'Explore your next stay',
              ),
              SizedBox(
                height: 5,
              ),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.6,
                children: List.generate(
                  propertyModel.length,
                  (index) => buildGridProduct(propertyModel[index], context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildGridProduct(PropertyModel model, context) {
  bool isFav = true;

  if (AppCubit.get(context).favorites[model.propertyId] == false ||
      AppCubit.get(context).favorites[model.propertyId] == null) {
    isFav = false;
  }

  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
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
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage('${model.thumbnail}'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .changeFavorites(propertyID: model.propertyId);
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
                  '${model.name}',
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
                  '${model.description}',
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
                      '${model.price} / night',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${model.category}',
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
}
