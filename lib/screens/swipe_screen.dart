import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Content {
    final String name;
    final int age;
    final String breed;
    final String description;
    final AssetImage image;

    Content({required this.name, required this.age, required this.breed, required this.description, required this.image});
}

class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    void addAnimalCards() async {
      // await list_animals

      // loop animals and build Content
      for (int i = 0; i < 1; i++) {
        _swipeItems.add(SwipeItem(
            content: Content(name: 'aaaaa', age: 1, breed: 'abc', description: 'asdasd dsa sd sd aasdas dsaa', image: AssetImage('images/petHomeScreen.png')),
            likeAction: () {
            },
            nopeAction: () {
            },
            superlikeAction: () {
            },
            onSlideUpdate: (SlideRegion? region) async {
            }
          )
        );
      }

    }

    addAnimalCards();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
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
                  if(_swipeItems.length < 1){return SizedBox();}
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
                                Text(_swipeItems[index].content.name),
                                Text(_swipeItems[index].content.age.toString())
                              ]
                            ),
                            Text(_swipeItems[index].content.breed),
                            Expanded(child: Text(_swipeItems[index].content.description))
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