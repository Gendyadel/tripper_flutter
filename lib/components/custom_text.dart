import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  CustomText({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
