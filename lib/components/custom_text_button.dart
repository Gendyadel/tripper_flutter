import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  @required
  final Function onPressed;
  @required
  final String text;

  CustomTextButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('${text.toUpperCase()}'),
    );
  }
}
