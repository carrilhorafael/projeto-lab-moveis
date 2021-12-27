import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_lab/screens/home.dart';

import 'package:projeto_lab/screens/search_settings.dart';
import 'package:projeto_lab/tab_view.dart';

import '../auth.dart';
import 'shared/background.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text('Fluxo normal do App'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(title: "PeTinder")),
                );
              },
            ),
            TextButton(
              child: Text('Testar configurações de busca'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Background(child: SearchSettingsPage())),
                );
              },
            ),
            TextButton(
                child: Text('Testar login'),
                onPressed: () {
                  login("bruno@email.com", "supernenechi").then(print);
                }),
            TextButton(
                child: Text('Tab View'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TabView()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
