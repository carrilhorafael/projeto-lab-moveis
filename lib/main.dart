import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_content.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            throw Exception("Problem with firebase initialization!");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return AppContent();
          }

          return Loading();
        });
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr, child: Text("loading..."));
  }
}
