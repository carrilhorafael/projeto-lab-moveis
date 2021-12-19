import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:projeto_lab/screens/search_settings.dart';

import '../auth.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text('Testar configurações de busca'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            TextButton(
                child: Text('Testar login'),
                onPressed: () {
                  login("bruno@email.com", "supernenechi").then(print);
                })
          ],
        ),
      ),
    );
  }
}
