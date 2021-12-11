import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/home.dart';

class AppContent extends StatelessWidget {
  const AppContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'BrunoAce',
        //primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PeTinder'),
    );
  }
}
