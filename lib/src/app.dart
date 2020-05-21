import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixri/src/views/application/application_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[600],
        accentColor: Colors.lightBlue[400],
        fontFamily: 'Nunito',
      ),
      home: ApplicationPage(),
    );
  }
}
