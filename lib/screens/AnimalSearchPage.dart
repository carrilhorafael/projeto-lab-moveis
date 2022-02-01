import 'package:flutter/material.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:swipe_cards/draggable_card.dart';

import 'package:swipe_cards/swipe_cards.dart';
import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/providers.dart';
class AnimalSearchPage extends ConsumerStatefulWidget {
  AnimalSearchPage({Key? key}) : super(key: key);

  @override
  _AnimalSearchPageState createState() => _AnimalSearchPageState();
}

class _AnimalSearchPageState extends ConsumerState<AnimalSearchPage> {
  List<Pet>_pets = [];


  List<SwipeItem> _swipeItems = [];
  MatchEngine _matchEngine = MatchEngine();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    List<Pet> pets = [];
        () async {
      final petSearchService = ref.read(petSearchServiceProvider);
      SearchOptions? searchOptions = await petSearchService.retrieve();

      if (searchOptions != null) {

        pets = await petSearchService.searchMore(
            searchOptions);
      } else {
        Set<Size> sizes = {Size.small, Size.medium, Size.big};
        Set<String>races = {"Puddle", "Raca02", "Raca03"};
        Set<String>species = {"Dog", "Cat", "Cachorro", "Gato"};
        searchOptions = SearchOptions(maxAge: 300, maxDistance: 1000);
        searchOptions.species = species;
        searchOptions.races = races;
        searchOptions.sizes = sizes;

        pets = await petSearchService.searchMore(
            searchOptions);

        print(pets.length);
      };
      List<Pet> SwipePets = [];
      List <Interest> userInterests = [];
      final interestService = ref.read(interestServiceProvider);
      userInterests =
      await interestService.findInterests(AuthService.currentUser()!);

      List<String> petsIdInterests = [];


      for (final interest in userInterests) {
        petsIdInterests.add(interest.petId);
      };
      for (final pet in pets) {
        if (!petsIdInterests.contains(pet.id)) {
          SwipePets.add(pet);
        }
      }

      setState(() {
        print("CARALHOOOOOOOOOOOOOOOOOOOOOOOO");
        _pets = SwipePets;
      });


      for (int i = 0; i < _pets.length; i++) {
        _swipeItems.add(SwipeItem(
            content: Content(text: _pets[i].name,
                age: "${_pets[i].age}",
                description: _pets[i].description),
            likeAction: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Liked ${_names[i]}"),
                duration: Duration(milliseconds: 500),
              ));
            },
            nopeAction: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Nope ${_names[i]}"),
                duration: Duration(milliseconds: 500),
              ));
            },
            superlikeAction: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Superliked ${_names[i]}"),
                duration: Duration(milliseconds: 500),
              ));
            },
            onSlideUpdate: (SlideRegion? region) async {
              print("Region $region");
            }));
      }

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
      super.initState();
    }();
  }

  @override
  Widget build(BuildContext context) {
    if (_matchEngine == null) {
      return Text("Wait");
    } else {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Teste"),
          ),
          body: Container(
              child: Column(children: [
                Container(
                  height: 550,
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          //color: _swipeItems[index].content.color,
                          color: Colors.white,
                          child: Column(children: [Text(
                            _swipeItems[index].content.text,
                            style: TextStyle(fontSize: 13),
                          ),
                            Text(
                              _swipeItems[index].content.age,
                              style: TextStyle(fontSize: 6),
                            )
                          ]));
                    },
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.text}, index: $index");
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
/*              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.nope();
                      },
                      child: Text("Nope")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.superLike();
                      },
                      child: Text("Superlike")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.like();
                      },
                      child: Text("Like"))
                ],
              )*/
              ])));
    }
  }
}



class Content {
  final String text;
  final String age;
  final String description;

  Content({required this.text, required this.age, required this.description});
}