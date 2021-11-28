import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: Container()
    );
  }
  
}
class SignupForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Crie uma conta"),
        TextInput("Nome", "Digite seu nome completo")
      ]
    );
  }
}

class TextInput extends StatelessWidget {

  final String label;
  final String placeholder;

  TextInput(this.label, this.placeholder);

  @override 
  Widget build(BuildContext context) {
    return TextFormField();
  }
}