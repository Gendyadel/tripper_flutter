import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData trailingIcon;
  final Function onTap;

  CustomListTile({this.title, this.trailingIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
      trailing: Icon(
        trailingIcon,
        color: Colors.grey.shade600,
      ),
      onTap: onTap,
    );
  }
}
