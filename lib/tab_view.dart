import 'package:flutter/material.dart';
import 'package:projeto_lab/screens/search_settings.dart';

class TabView extends StatelessWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: Text('Animal Search')),
            SearchSettingsPage(title: 'Configurações de busca'),
            Center(child: Text("Chat Screen")),
            Center(child: Text("Profile Screen")),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(tabs: [
            Tab(
              icon: TabIcon(Icons.pets_outlined),
            ),
            Tab(
              icon: TabIcon(Icons.settings),
            ),
            Tab(
              icon: TabIcon(Icons.chat_bubble_outline),
            ),
            Tab(
              icon: TabIcon(Icons.person_outline),
            )
          ]),
          color: Colors.white,
        ),
      ),
      length: 4,
    );
  }
}

class TabIcon extends StatelessWidget {
  final IconData iconData;

  const TabIcon(this.iconData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: Colors.grey,
    );
  }
}
