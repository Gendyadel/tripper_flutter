import 'package:flutter/material.dart';

ButtonStyle signInButton = ButtonStyle();

///AppBar Styles

TextStyle appBarTitleTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 30,
  fontFamily: 'Dynalight',
);

///bottom navigation Styles
TextStyle bottomNavSelectedLabelStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

TextStyle bottomNavUnSelectedLabelStyle =
    TextStyle(fontSize: 10, color: Colors.grey);

IconThemeData selectedIconTheme = IconThemeData(size: 25, opacity: 1);
IconThemeData unSelectedIconTheme = IconThemeData(size: 19, opacity: 0.6);
