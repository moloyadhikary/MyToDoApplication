import 'package:flutter/material.dart';

class WidgetHelper {
  static DropdownMenuItem<String> getTaskTypeDDL(String value, String text) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(text),
    );
  }

  static PopupMenuItem getTasktypePopUpMenu(String value, String title) {
    return PopupMenuItem(
      child: Text(title),
      value: value,
    );
  }

  static ListTile getSubTaskTile(String title, String description, int id) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
