import 'package:flutter/material.dart';

class CardWidgets extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onPressed;

  CardWidgets(this.title, this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          maxLines: 1,
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        onTap: onPressed,
      ),
    );
  }
}