import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_lab/domain/entities/pet.dart';

import 'form_pet.dart';

class MyPetsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(child: Text("Meus Pets"))
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PetForm())), 
                child: Center(child: Text("Adicionar Pet"))
              )
            ),
            PetsList()
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
    return FutureBuilder<List>(
      future: pets,
      builder: ( context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {return Text("Erro");}
          else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: PetMiniature(
                    pet: new Pet(
                      id: snapshot.data![index].id,
                      ownerId: snapshot.data![index].ownerId,
                      name: snapshot.data![index].name,
                      description: snapshot.data![index].description,
                      species: snapshot.data![index].species,
                      race: snapshot.data![index].race,
                      size: snapshot.data![index].size,
                      age: snapshot.data![index].age
                    )
                  )
                );
              },
              itemCount: snapshot.data!.length
            );
          }
        } 
        else {return CircularProgressIndicator();}
      }
    );
  }
}

class PetMiniature extends StatelessWidget {

  final Pet pet;
  PetMiniature({required this.pet});

   @override
  Widget build(BuildContext context) {
    return SizedBox (
      width: 300, 
      height: 100,
      child: Row (
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(pet.name),
                  Text(pet.age.toString())
                ]
              ),
              Text(pet.race),
              Expanded(child: Text(pet.description))
            ]
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: PopupMenuButton(
              onSelected: (String value) {
                if (value == "Excluir") {
                  // TODO Rotina de exclusão de pet
                }
                if (value == "Editar") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PetForm()));
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Editar', 'Excluir'}.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }
            )
          )
        ]
      )
    );
  }
}