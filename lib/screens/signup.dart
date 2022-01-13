import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart' as Location;
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/tab_view.dart';
import 'components/main_dropdown.dart';
import 'components/main_text_area.dart';
import 'components/main_text_input.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Text("Entre com suas contas"),
            Row(children: <Widget>[
              //TODO Botões de Login com Google e Facebook
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(child: Text("OU"))),
            SignupForm()
          ]),
        )));
  }
}

class SignupForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends ConsumerState<SignupForm> {
  final _teName = TextEditingController();
  final _teEmail = TextEditingController();
  final _tePassword = TextEditingController();
  final _tePasswordConfirmation = TextEditingController();
  final _tePhone = TextEditingController();
  final _teCEP = TextEditingController();
  final _teAddress = TextEditingController();
  final _teComplement = TextEditingController();
  final _teBio = TextEditingController();

  Location.State? _state;

  @override
  Widget build(BuildContext context) {
    final _states = Location.State.validStates.map((e) {
      return DropdownMenuItem<Location.State>(
        child: Text("${e.name} / ${e.abbreviation}"),
        value: e,
      );
    }).toList();

    final authService = ref.watch(authServiceProvider);

    void _submit() {
      final User user = User(
          email: _teEmail.text,
          name: _teName.text,
          phone: _tePhone.text,
          address: Address(
              postalCode: _teCEP.text,
              address: _teAddress.text,
              complement: _teComplement.text,
              state: _state!));

      authService.register(user.email, _tePassword.text, user).then((_) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => TabView()));
      }).onError((e, _) {
        print(e);
      });
    }

    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Form(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text("Crie uma conta"),
            MainTextInput("Nome", "Digite seu nome completo", _teName),
            MainTextInput("Email", "Digite seu email", _teEmail),
            MainTextInput("Senha", "Digite sua senha", _tePassword,
                hideText: true),
            MainTextInput("Confirmar sua senha", "Confirme sua senha",
                _tePasswordConfirmation),
            MainTextInput("Telefone", "Digite seu telefone", _tePhone),
            MainTextInput("CEP", "Digite seu CEP", _teCEP),
            MainTextInput("Rua", "Rua e número", _teAddress),
            MainTextInput("Complemento", "Apartamento, bloco", _teComplement),
            MainDropdown(_states, "Selecione um Estado", "Estado", (state) {
              setState(() {
                _state = state;
              });
            }),
            MainTextArea("Bio", "Fale um pouco sobre você", _teBio),
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: ElevatedButton(
                    onPressed: () => _submit(),
                    child: const Text("Continuar"))),
          ])),
    ));
  }
}
