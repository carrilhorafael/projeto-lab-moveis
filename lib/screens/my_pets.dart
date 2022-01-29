import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/pet.dart';

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
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  // TODO Implementar serviço de recuperação de pets;
  final Future <List<Pet>> pets = [] as Future<List<Pet>>; 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pets,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {return Text("Erro");}
          else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              itemBuilder: (context, int index) {
                return Text("Widget de Pet");
              }
            );
          }
        } 
        else {return CircularProgressIndicator();}
      }
    );
  }
}

class PetMinuature extends StatelessWidget {
  
}