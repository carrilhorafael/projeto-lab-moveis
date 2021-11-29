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
        MainTextInput("Nome", "Digite seu nome completo"),
        MainTextInput("Email", "Digite seu email"),
        MainTextInput("Senha", "Digite sua senha"),
        MainTextInput("Confirmar sua senha", "Confirme sua senha"),
        MainTextInput("Telefone", "Digite seu telefone"),
        ElevatedButton(onPressed: () {}, child: const Text("Continuar"))
      ]
    );
  }
}

class MainTextInput extends StatelessWidget {

  final String _label;
  final String _hintText;

  MainTextInput(this._label, this._hintText);

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          TextFormField(
            decoration: InputDecoration(
              labelText: _label,
              hintText: _hintText
            )
          ),
        ]
      )
    );
  }
}