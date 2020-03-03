import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
final String title;
final String content;
final String falseText;
final String trueText;

AlertDialogWidget(this.title, this.content, this.falseText, this.trueText);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title:const Text('Are you sure?'),
        content:const Text('Do you want to remove the item from the cart?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              })
        ]);
  }
}
