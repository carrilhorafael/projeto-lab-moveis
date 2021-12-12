import 'package:flutter/material.dart';
import 'package:projeto_lab/components/button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text('Petinder'.toUpperCase(),
                      style: TextStyle(fontSize: 48)),
                ),
              ),
              Text('Entrar',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email:',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    TextFormField(),
                    SizedBox(height: 30),
                    Text('Senha:',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    TextFormField(obscureText: true),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                          child: Button(text: 'Entrar', onPressed: () {})),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
