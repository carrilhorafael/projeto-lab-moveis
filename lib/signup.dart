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

  final TextEditingController _controllerNameField = TextEditingController();
  final TextEditingController _controllerEmailField = TextEditingController();
  final TextEditingController _controllerPasswordField = TextEditingController();
  final TextEditingController _controllerPasswordConfirmationField = TextEditingController();
  final TextEditingController _controllerPhoneField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Crie uma conta"),
          MainTextInput("Nome", "Digite seu nome completo", _controllerNameField),
          MainTextInput("Email", "Digite seu email", _controllerEmailField),
          MainTextInput("Senha", "Digite sua senha", _controllerPasswordField),
          MainTextInput("Confirmar sua senha", "Confirme sua senha", _controllerPasswordConfirmationField),
          MainTextInput("Telefone", "Digite seu telefone", _controllerPhoneField),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: ElevatedButton(onPressed: () {}, child: const Text("Continuar"))
          )
        ]
      )
    );
  }
}

class MainTextInput extends StatelessWidget {

  final String _label;
  final String _hintText;
  final TextEditingController _controller;

  MainTextInput(this._label, this._hintText, this._controller);

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          TextFormField(
            controller: _controller,
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