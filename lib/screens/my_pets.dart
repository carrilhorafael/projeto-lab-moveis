import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
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

class PetsList extends ConsumerStatefulWidget {
  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends ConsumerState<PetsList> {

  @override
  Widget build(BuildContext context) {
    final petService = ref.watch(petServiceProvider);
    final Future <List<Pet>> pets = petService.ownedBy(AuthService.currentUser()); 

    return FutureBuilder<List>(
      future: pets,
      builder: ( context, AsyncSnapshot<List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {return Text("Erro");}
          else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  child: Padding(
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
                  ),
                  background: Container( color: Colors.red),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) { 
                    setState(() => petService.delete(snapshot.data![index].id));
                  },
                  key: ValueKey<int>(snapshot.data![index])
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

class PetMiniature extends ConsumerStatefulWidget {

  final Pet pet;

  PetMiniature({required this.pet});

  @override
  _PetMiniatureState createState() => _PetMiniatureState(pet);
}

class _PetMiniatureState extends ConsumerState<PetMiniature>  {

  Pet pet;
  String imageURL = "";
  _PetMiniatureState(this.pet);

  @override
  Widget build(BuildContext context) {

    final petService = ref.watch(petServiceProvider);

    if (imageURL == "") {
      setState(() async{
        List imagesURL = await petService.fetchImagesURL(pet.id);
        imageURL = imagesURL[0];
      });
    }

    return Column(
      children: <Widget>[
        Image.network(
          imageURL,
          width: 300,
          height: 100
        ),
        SizedBox (
          width: 300, 
          height: 100,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
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
            )
          )
        )
      ]
    );
  }
}