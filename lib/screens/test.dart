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
                      .login("bruno@email.com", "supernenechi")
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
                      builder: (context) =>
                          Background(child: MapSample(LatLng(37.42796133580664, -122.085749655962),LatLng(37.43296265331129, -122.08832357078792)))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
