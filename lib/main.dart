import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripper_flutter/layout/user_layout.dart';
import 'package:tripper_flutter/service/bloc_observer.dart';
import 'package:tripper_flutter/service/storage/cache_helper.dart';
import 'package:tripper_flutter/src/app_root.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/login/login_screen.dart';
import 'package:tripper_flutter/views/on_boarding/on_boarding_screen.dart';
import 'package:tripper_flutter/views/register/register_by_mail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  if (onBoarding != null) {
    if (uId != null) {
      widget = UserLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  widget = LoginScreen();

  runApp(AppRoot(widget));
}
