import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/components/button.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/screens/components/main_text_input.dart';

import '../tab_view.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  final _teEmail = TextEditingController();
  final _tePass = TextEditingController();

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
                    MainTextInput("Email", "digite seu email", _teEmail),
                    SizedBox(height: 30),
                    MainTextInput("Password", "digite sua senha", _tePass,
                        hideText: true),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                          child: Button(
                              text: 'Entrar',
                              onPressed: () async {
                                try {
                                  final auth = ref.read(authServiceProvider);
                                  await auth.login(_teEmail.text, _tePass.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabView()),
                                  );
                                } catch (e) {
                                  // caso nao logue, faca algo
                                }
                              })),
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
