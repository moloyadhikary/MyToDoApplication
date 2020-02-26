import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

import '../widgets/app_drawer.dart';
import '../widgets/about/card_widget.dart';

class AboutScreen extends StatelessWidget {
  static const pageRouteName = '/about';

  
  void _onCallPressed() async {
     const phoneNumber = 'tel:+8801717219723';
    if (await ul.canLaunch(phoneNumber)) {
      await ul.launch(phoneNumber);
    } else {
      return null;
    }
  }

  void _onEmailPressed() async {
    const url = 'mailto:moloy.cse20@gmail.com';
    if (await ul.canLaunch(url)) {
      await ul.launch(url);
    } else {
      print('Error');
    }
  }

  void _onWebPressed() async {
    const url = 'https://github.com/moloyadhikary/MyToDoApplication';
    if (await ul.canLaunch(url)) {
      await ul.launch(url);
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About This Application',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: AppDrawer(),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 10),
                Text('This APP is developed as a flutter learning project by:', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,                                
                ), textAlign: TextAlign.center),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/PP_IMAGE_SM2.jpg'),
                ),
                Text(
                  'Moloy Adhikary',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                  ),
                ),
                Text(
                  'Software Engineer',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal[50],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.teal.shade700,
                  ),
                ),
                CardWidgets('+880 1717 219 723', Icon(Icons.call), _onCallPressed),
                CardWidgets(
                    'moloy.cse20@gmail.com', Icon(Icons.email), _onEmailPressed),
                CardWidgets(
                    'github.com/moloyadhikary', Icon(Icons.web), _onWebPressed),
                CardWidgets(
                    'Dhaka, Bangladesh', Icon(Icons.location_city), null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
