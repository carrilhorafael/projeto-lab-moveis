import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SignupPageFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget> [
            Text("Entre com suas contas"),
            Row(children: <Widget> [
            //TODO Botões de Login com Google e Facebook
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: Text("OU"))
            ),
            SignupForm()
          ]
        )
      )
    );
  }
  
}
class SignupForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Crie uma conta"),
            MainTextInput("Nome", "Digite seu nome completo"),
            MainTextInput("Email", "Digite seu email"),
            MainTextInput("Senha", "Digite sua senha"),
            MainTextInput("Confirmar sua senha", "Confirme sua senha"),
            MainTextInput("Telefone", "Digite seu telefone"),
            MainTextInput("CEP", "Digite seu CEP"),
            MainTextInput("Rua", "Ruua e número"),
            MainTextInput("Complemento", "Apartamento, bloco"),
            MainTextInput("Estado", "Rio de Janeiro"),
            MainTextArea("Bio", "Fale um pouco sobre você"),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ();
                  }));
                },
                child: const Text("Continuar")
              )
            )
          ]
        )
      )
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

class MainTextArea extends StatelessWidget {

  final String _label;
  final String _hintText;

  MainTextArea(this._label, this._hintText);

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