import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_flat_button.dart';
import 'package:tripper_flutter/components/custom_text_button.dart';
import 'package:tripper_flutter/components/toast.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/chat/chat_screen.dart';
import 'package:tripper_flutter/views/search/search_screen.dart';

class UserLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var model = cubit.userModel;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Text(
                'TRIPPER',
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                  iconSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      ChatScreen(),
                    );
                  },
                  icon: Icon(
                    Icons.forum_outlined,
                  ),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border_outlined,
                ),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.flight_land_outlined,
                ),
                label: 'Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
