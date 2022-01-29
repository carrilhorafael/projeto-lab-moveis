import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPetsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(child: Text("Meus Pets"))
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                onPressed: null, 
                child: Center(child: Text("Adicionar Pet"))
              )
            ),
          ]
        )
      )
    );
  }
}

class PetsList extends StatefulWidget {
  @override
  State<PetsList> createState() {
    _PetsListState();
    throw UnimplementedError();
  }
}

class _PetsListState extends State<PetsList> {
  // TODO Implementar serviço de recuperação de pets
  // final List<Pet> pets = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      itemBuilder: (BuildContext context, int index) {
        return Text("Widget de Pet");
      }
    );
  }
}