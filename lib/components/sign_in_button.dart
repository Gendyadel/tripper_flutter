import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;
  final double height;
  final String assetName;
  final String text;
  final double elevation;

  SignInButton({
    this.assetName,
    @required this.text,
    @required this.onPressed,
    this.borderRadius: 6,
    this.backgroundColor,
    this.textColor,
    this.height: 60,
    this.elevation: 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: MaterialButton(
          elevation: elevation,
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              assetName == null
                  ? Icon(
                      Icons.email,
                      color: Colors.white,
                    )
                  : Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
              Opacity(
                opacity: 0,
                child: Icon(
                  Icons.email,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor));
  }
}
