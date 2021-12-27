import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class FirebaseInit extends StatefulWidget {
  final Widget app;

  FirebaseInit(this.app);

  @override
  _FirebaseInitState createState() => _FirebaseInitState();
}

class _FirebaseInitState extends State<FirebaseInit> {
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
            return widget.app;
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
