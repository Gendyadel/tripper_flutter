import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripper_flutter/src/styles.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: scaffoldColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: appbarColor,
    elevation: 0,
    titleTextStyle: appBarTitleTextStyle,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 30,
    selectedLabelStyle: bottomNavSelectedLabelStyle,
    unselectedLabelStyle: bottomNavUnSelectedLabelStyle,
    selectedIconTheme: selectedIconTheme,
    unselectedIconTheme: unSelectedIconTheme,
    backgroundColor: scaffoldColor,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
);
