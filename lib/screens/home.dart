import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:projeto_lab/screens/search_settings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: null,
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                    width: width,
                    height: width * 1.6898,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/petHomeScreen.png'),
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                          child: TextButton(
                            child: Text('ENTRAR',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25)),
                            onPressed: () {
                              // TODO send to login page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()),
                              );
                            },
                          )),
                    )),
                Container(
                    width: width,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(20, 4))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text('PETINDER',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF5551FF),
                                  fontSize: 25)),
                          SizedBox(height: 15),
                          Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(height: 20),
                          SizedBox(
                              width: width * 0.8,
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green)),
                                child: Text('Faça sua conta',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17)),
                                onPressed: () {
                                  // TODO send to create account page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage()),
                                  );
                                },
                              ))
                        ]))
              ]))
        ])));
  }
}
