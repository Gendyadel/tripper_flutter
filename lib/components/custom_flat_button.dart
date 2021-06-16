import 'package:flutter/material.dart';
import 'package:tripper_flutter/src/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width;
  final Color backgroundColor;
  final bool isUpperCase;
  final double radius;

  CustomButton({
    @required this.onPressed,
    @required this.text,
    this.width = double.infinity,
    this.radius = 6,
    this.isUpperCase = true,
    this.backgroundColor = secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundColor),
    );
  }
}
