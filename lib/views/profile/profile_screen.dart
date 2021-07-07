import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_list_tile.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/profile/edit_personal_information.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var model = cubit.userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        '${model.picture}',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        '${model.displayName}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: 'Personal Information',
                trailingIcon: Icons.account_circle_sharp,
                onTap: () {
                  navigateTo(context, EditPersonalInfo());
                },
              ),
              CustomListTile(
                title: 'Switch to host mode',
                trailingIcon: Icons.shuffle,
                onTap: () {},
              ),
              CustomListTile(
                title: 'Logout',
                trailingIcon: Icons.logout,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
