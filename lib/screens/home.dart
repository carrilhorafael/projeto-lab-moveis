import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_lab/screens/login.dart';
import 'package:projeto_lab/screens/signup.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';





class BlocHomeOneSignal {
//Função inicial que seta o AppId necessário para o OneSignal funcionar
  void initOneSignal() {
    OneSignal.shared.setAppId("76726102-6074-498c-a4fb-2dfd1db62961");
    OneSignal().userProvidedPrivacyConsent();
  }
}

class HomePage extends StatefulWidget {
  //Página de entrada do app
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //Estado inicial inicializa o onesignal
    var bloc = BlocHomeOneSignal();
    bloc.initOneSignal();


    super.initState();


  }

  //Constrói o widget
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
                      image: DecorationImage( //Mostra a imagem da tela inicial
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
                            child: Text('ENTRAR', //Define o botão de entrada
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute( //Vai para a página de login
                                    builder: (context) => Login()),
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
                                child: Text('Faça sua conta', //Define o botão para criar uma conta
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(  //Vai para a página para criar a conta
                                        builder: (context) => SignupPage()),
                                  );
                                },
                              ))
                        ]))
              ]))
        ])));
  }
}
