import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:projeto_lab/domain/entities/pet_search/search_options.dart';
import 'package:projeto_lab/domain/entities/pet.dart';

SearchOptions searchSettings = SearchOptions(maxAge: 5, maxDistance: 9);

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //title: 'Configurações de busca',
      //theme: ThemeData(
      //primarySwatch: Colors.purple,
      //visualDensity: VisualDensity.adaptivePlatformDensity,
      //),
      //home:
      body: Center(child: MyHomePage(title: 'Configurações de busca')),
    );
  }
}

class Raca {
  final String name;

  Raca({
    required this.name,
  });
}

class Tamanho {
  final String name;
  Size size;
  Tamanho({
    required this.name,
    required this.size,
  });
}

class Animal {
  final String name;

  Animal({
    required this.name,
  });
}

/*
class Animal {
  final int id;
  final String name;

  Animal(int id,String name){
    final this.id = 0;
    this.id = id;
    this.name = name;
  };
}
*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _currentSliderValue = searchSettings.maxAge;
  double _currentSliderValue2 = searchSettings.maxDistance;
  static List<Animal> _animals = [
    Animal(name: "Cachorro"),
    Animal(name: "Gato"),
  ];

  static List<Raca> _racas = [
    Raca(name: "Raça 1"),
    Raca(name: "Raça 2"),
    Raca(name: "Raça 3"),
    Raca(name: "Raça 4"),
    Raca(name: "Raça 5"),
    Raca(name: "Raça 6"),
  ];

  static List<Tamanho> _tamanhos = [
    Tamanho(name: "Pequeno", size: Size.small),
    Tamanho(name: "Médio", size: Size.medium),
    Tamanho(name: "Grande", size: Size.big),
  ];

  final _items = _animals
      .map((animal) => MultiSelectItem<Animal?>(animal, animal.name))
      .toList();

  final _itemsracas =
      _racas.map((raca) => MultiSelectItem<Raca?>(raca, raca.name)).toList();

  final _itemstamanhos = _tamanhos
      .map((tamanho) => MultiSelectItem<Tamanho?>(tamanho, tamanho.name))
      .toList();

  static List<Animal?> convertListType(
      List<String> listSpecie, List<Animal?> animals) {
    List<Animal?> species = [];
    for (String name in listSpecie) {
      for (Animal? animal in animals) {
        if (animal!.name == name) {
          species.add(animal);
        }
      }
    }

    return species;
  }

  static List<Object?> convertListType2(
      List<String> listRace, List<Raca?> racas) {
    List<Object?> races = [];

    for (String name in listRace) {
      for (Raca? raca in racas) {
        if (raca!.name == name) {
          races.add(raca);
        }
      }
    }

    return races;
  }

  static List<Tamanho?> convertListType3(
      List<Size?> listTamanho, List<Tamanho?> tamanhos) {
    List<Tamanho?> size = [];
    var myMapSize = {
      Size.small: 'Pequeno',
      Size.medium: 'Médio',
      Size.big: 'Grande'
    };
    //print(listTamanho);
    for (Size? name in listTamanho) {
      for (Tamanho? tamanho in tamanhos) {
        String? stringSize = myMapSize[name];
        if (tamanho!.name == stringSize) {
          size.add(tamanho);
        }
      }
    }
    //print(size);
    return size;
  }

  List<Animal?> _selectedAnimals =
      convertListType(searchSettings.species.toList(), _animals);
  List<Object?> _selectedAnimals2 =
      convertListType2(searchSettings.races.toList(), _racas);
  List<Tamanho?> _selectedAnimals3 =
      convertListType3(searchSettings.sizes.toList(), _tamanhos);

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        //title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.651, 1.000],
            colors: [
              Color(0XFF5551FF),
              Color(0XFF716EFD),
              Color(0XFFF5F4F6)
              //Color.fromRGBO(51, 46, 232, 100),
              //Color.fromRGBO(51, 46, 232, 100),
              //Color.fromRGBO(51, 46, 232, 100)
              //Color.fromRGBO(113, 110, 253,100),
              //Color.fromRGBO(245, 244, 246,100)
              //Color.fromRGBO(85, 81, 255, 100),
              //Color.fromRGBO(85, 81, 255, 100)
            ],
          )),
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Configurações de busca",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19))),
              SizedBox(height: 25),
              //################################################################################################
              // Rounded blue MultiSelectDialogField
              //################################################################################################
              MultiSelectDialogField(
                initialValue: _selectedAnimals,
                items: _items,
                title: Text("Tipo"),
                selectedColor: Colors.black.withOpacity(1),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 12)),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                buttonText: Text(
                  "Tipo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                onConfirm: (results) {
                  _selectedAnimals = results as List<Animal?>;
                },
              ),
              SizedBox(height: 50),
              //################################################################################################
              // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
              // decoration applied. This allows the ChipDisplay to render inside the same Container.
              //################################################################################################
              Container(
                decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColor.withOpacity(.4),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 15)),
                  border: Border.all(
                    //color: Theme.of(context).primaryColor,
                    color: Colors.white,

                    width: 2,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField(
                      initialValue: _selectedAnimals2,
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Raça", style: TextStyle(fontSize: 14)),
                      title: Text("Raça", style: TextStyle(fontSize: 14)),
                      items: _itemsracas,
                      onConfirm: (values) {
                        _selectedAnimals2 = values as List<Object?>;

                        //print(_selectedAnimals2);
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            _selectedAnimals2.remove(value);
                          });
                        },
                      ),
                    ),
                    //Para verificar se está nulo
                    /*
                   _selectedAnimals2 == null || _selectedAnimals2.isEmpty
                        ? Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "",
                          style: TextStyle(color: Colors.black54),
                        ))*/
                    // : Container(),
                    //
                  ],
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectBottomSheetField with validators
              //################################################################################################
              Container(
                  decoration: BoxDecoration(
                      //color: Theme.of(context).primaryColor.withOpacity(.4),
                      color: Colors.white),
                  child: Column(children: [
                    MultiSelectBottomSheetField<Tamanho?>(
                      initialValue: _selectedAnimals3,
                      key: _multiSelectKey,
                      initialChildSize: 0.7,
                      maxChildSize: 0.95,
                      title: Text("Tamanho", style: TextStyle(fontSize: 14)),
                      buttonText:
                          Text("Tamanho", style: TextStyle(fontSize: 14)),
                      items: _itemstamanhos,
                      searchable: true,
                      validator: (values) {
                        if (values == null || values.isEmpty) {
                          return "Required";
                        }
                        return null;
                      },
                      onConfirm: (values) {
                        setState(() {
                          _selectedAnimals3 = values as List<Tamanho?>;
                        });
                        _multiSelectKey.currentState!.validate();
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (item) {
                          setState(() {
                            _selectedAnimals3.remove(item);
                          });
                          _multiSelectKey.currentState!.validate();
                        },
                      ),
                    )
                  ])),
              SizedBox(height: 40)

              /*,
              //################################################################################################
              // MultiSelectChipField
              //################################################################################################
              MultiSelectChipField(
                items: _items,
                //initialValue: [_animals[4], _animals[7], _animals[9]],
                title: Text("Animals"),
                headerColor: Colors.blue.withOpacity(0.5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.8),
                ),
                selectedChipColor: Colors.blue.withOpacity(0.5),
                selectedTextStyle: TextStyle(color: Colors.blue[800]),
                onTap: (values) {
                  //_selectedAnimals4 = values;
                },
              ),
              SizedBox(height: 40)

              ,
              //################################################################################################
              // MultiSelectDialogField with initial values
              //################################################################################################
              MultiSelectDialogField(
                onConfirm: (val) {
                  _selectedAnimals5 = val as List<Animal>;
                },
                items: _items,
                initialValue:
                _selectedAnimals5, // setting the value of this in initState() to pre-select values.
              )*/
              ,
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      // with no TextStyle it will have default text style
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Idade',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white)),
                        TextSpan(
                            text: ' (em anos)',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  )),

              //Text("Idade (em anos)" ,style: TextStyle(color: Colors.white,
              //fontWeight: FontWeight.bold, fontSize: 15)),

              SliderTheme(
                data: SliderThemeData(
                    valueIndicatorColor: Colors.white,
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    valueIndicatorTextStyle: TextStyle(color: Colors.black),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8)),
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 12,
                  divisions: 12,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 40),

              Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      // with no TextStyle it will have default text style
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Distância',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white)),
                        TextSpan(
                            text: ' (em km)',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                  )),
              SliderTheme(
                data: SliderThemeData(
                    valueIndicatorColor: Colors.white,
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    valueIndicatorTextStyle: TextStyle(color: Colors.black),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8)),
                child: Slider(
                  value: _currentSliderValue2,
                  min: 0,
                  max: 12,
                  divisions: 12,
                  label: _currentSliderValue2.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue2 = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                  width: width * 0.8,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                    child: Text('Salvar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Set<String> speciesSet = {};
                      Set<String> raceSet = {};
                      Set<Size> sizeSet = {};

                      for (Animal? animal in _selectedAnimals) {
                        speciesSet.add(animal!.name);
                      }
                      //for (Object? race in _selectedAnimals2){
                      //raceSet.add(race!.name);
                      //}

                      for (Animal? animal in _selectedAnimals) {
                        speciesSet.add(animal!.name);
                      }
                      // settingsTipo = _selectedAnimals;

                      for (Object? object in _selectedAnimals2) {
                        Raca? raca = object as Raca?;
                        raceSet.add(raca!.name);
                      }

                      var myMapSize = {
                        'Pequeno': Size.small,
                        'Médio': Size.medium,
                        'Grande': Size.big
                      };
                      for (Tamanho? tamanho in _selectedAnimals3) {
                        sizeSet.add(myMapSize[tamanho!.name]!);
                      }

                      //settingsRaca = _selectedAnimals2 as <Raca?>;
                      searchSettings.sizes = sizeSet;
                      searchSettings.species = speciesSet;
                      searchSettings.races = raceSet;
                      //print(settingsRaca);
                      searchSettings.maxAge = _currentSliderValue;
                      searchSettings.maxDistance = _currentSliderValue2;
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}