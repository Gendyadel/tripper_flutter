import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function onFieldSubmitted;
  final Function onChanged;
  final Function onTap;
  final Function suffixPressed;
  final bool isPassword;
  final Function validator;
  final String labelText;
  final IconData prefix;
  final IconData suffixIcon;
  final bool isClickable;
  final Key key;
  final double radius;
  final String hintText;

  CustomFormField(
      {@required this.controller,
      @required this.inputType,
      @required this.validator,
      @required this.labelText,
      @required this.prefix,
      this.onFieldSubmitted,
      this.onChanged,
      this.onTap,
      this.suffixPressed,
      this.isPassword = false,
      this.hintText = '',
      this.suffixIcon,
      this.isClickable = true,
      this.key,
      this.radius = 5});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: Icon(prefix),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
