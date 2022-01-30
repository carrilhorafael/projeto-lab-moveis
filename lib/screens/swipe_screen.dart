import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/screens/search_settings.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/domain/services/interest_service.dart';
import '../providers.dart';
// import 'package:flutter_riverpod/src/consumer.dart';

class Content {
    final String name;
    final int age;
    final String breed;
    final String description;
    final String petId;
    final AssetImage image;

    Content({required this.name, required this.age, required this.breed, required this.description, required this.image, required this.petId});
}

class SwipeScreen extends ConsumerStatefulWidget {
  SwipeScreen(this.searchOptions);
  final SearchOptions searchOptions;
  // UserMap(this.sourceUser, this.destinationUser);
  // final LatLng sourceUser;

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends ConsumerState<SwipeScreen> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  List<Pet> _pets = <Pet>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  void initState() {
    super.initState();

    void addAnimalCards() async {
      final petService = ref.read(petServiceProvider);
      final searchService = ref.read(petSearchServiceProvider);
      final _pets = await searchService.searchMore(widget.searchOptions);

      
      // print(_pets);

      // loop animals and build Content
      final interestService = ref.read(interestServiceProvider);
      for (int i = 0; i < _pets.length; i++) {
        // final imageUrl = await petService.fetchImagesURL(_pets[0].id);
        // final image = Image.network(imageUrl[0]);
        _swipeItems.add(SwipeItem(
            content: Content(name: _pets[i].name, age: _pets[i].age, breed: _pets[i].race, description: _pets[i].description, image: AssetImage('images/petHomeScreen.png'), petId: _pets[i].id),
            likeAction: () async {
              await interestService.add(Interest(petId: _pets[i].id, userId: AuthService.currentUser()!.id, status: Status.accepted));
            },
            superlikeAction: () async {
              await interestService.add(Interest(petId: _pets[i].id,userId: AuthService.currentUser()!.id, status: Status.accepted));
              // same as like?
            },
            // nopeAction: () {
            // },
            // onSlideUpdate: (SlideRegion? region) async {
            // }
          )
        );
      }
      setState((){});
    }

    addAnimalCards();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Stack(
            children: [Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  if(_swipeItems.length < 1){
                    return SizedBox();
                  } // should've been a loader
                  return Container (
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _swipeItems[index].content.image,
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                    child: Row (
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: _swipeItems[index].content.name,
                                    style: TextStyle(color: Colors.white)
                                  )),
                                  RichText(
                                  text: TextSpan(
                                    text: _swipeItems[index].content.age.toString(),
                                    style: TextStyle(color: Colors.white)
                                  )),
                              ]
                            ),
                            RichText(
                                  text: TextSpan(
                                    text: _swipeItems[index].content.breed,
                                    style: TextStyle(color: Colors.white)
                                  )),
                            Expanded(child: RichText(
                                  text: TextSpan(
                                    text: _swipeItems[index].content.description,
                                    style: TextStyle(color: Colors.white)
                                  ))
                                ),
                          ]
                        )
                      ]
                    )
                  );
                },
                onStackFinished: () {
                },
                itemChanged: (SwipeItem item, int index) {
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),

            // Botões, tira a necessidade de swipe
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ElevatedButton(
            //         onPressed: () {
            //           _matchEngine!.currentItem?.nope();
            //         },
            //         child: Text("Nope")),
            //     ElevatedButton(
            //         onPressed: () {
            //           _matchEngine!.currentItem?.superLike();
            //         },
            //         child: Text("Superlike")),
            //     ElevatedButton(
            //         onPressed: () {
            //           _matchEngine!.currentItem?.like();
            //         },
            //         child: Text("Like"))
            //   ],
            // )
            ///////
            
          ])));
  }
}