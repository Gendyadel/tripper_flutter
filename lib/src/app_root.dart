import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/blocs/login/login_cubit.dart';
import 'package:tripper_flutter/blocs/register/register_cubit.dart';
import 'package:tripper_flutter/blocs/search/search_cubit.dart';
import 'package:tripper_flutter/src/themes.dart';

class AppRoot extends StatelessWidget {
  // This widget is the root of your application.
  final Widget startWidget;

  AppRoot(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
          create: (context) => AppCubit()
            ..getUserData()
            ..getFavouritesData()
            ..getPropertiesData()
            ..getBannerData(),
        ),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Tripper',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
