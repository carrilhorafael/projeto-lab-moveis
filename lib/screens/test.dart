import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/screens/home.dart';

import 'package:projeto_lab/screens/search_settings.dart';
import 'package:projeto_lab/tab_view.dart';

import 'shared/background.dart';

import 'package:projeto_lab/screens/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:projeto_lab/screens/swipe_screen.dart';

class TestPage extends ConsumerWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  final authService = ref.read(authServiceProvider);
                  authService
                      .login("lauro@email.com", "labdisp")
                      .then((_) => print("loggado"));
                }),
            TextButton(
                child: Text('Tab View'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TabView()),
                  );
                }),
            TextButton(
              child: Text('Testar Mapa do chat'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => // LatLng são pegos do
                          Background(
                              child: UserMap(LatLng(-22.87838, -43.50415),
                                  LatLng(-22.88196, -43.52242)))),
                );
              },
            ),
            TextButton(
              child: Text('Testar Swipe'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => // LatLng são pegos do
                          Background(
                              child: SwipeScreen()
                            )
                          ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
