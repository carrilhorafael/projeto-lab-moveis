import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart'
    as LocationState;
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/providers.dart';
import 'components/main_dropdown.dart';
import 'components/main_text_area.dart';
import 'components/main_text_input.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(children: <Widget>[
          Text("Entre com suas contas"),
          Row(children: <Widget>[
            //TODO Botões de Login com Google e Facebook
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(child: Text("OU"))),
          SignupForm()
        ])));
  }
}

class SignupForm extends ConsumerWidget {
  final _teName = TextEditingController();
  final _teEmail = TextEditingController();
  final _tePassword = TextEditingController();
  final _tePasswordConfirmation = TextEditingController();
  final _tePhone = TextEditingController();
  final _teCEP = TextEditingController();
  final _teAddress = TextEditingController();
  final _teComplement = TextEditingController();
  final _teState = TextEditingController();
  final _teBio = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _states = LocationState.State.validStates.map((e) {
      return DropdownMenuItem<String>(
        child: Text("${e.name} / ${e.abbreviation}"),
        value: e.name,
      );
    }).toList();

    final userService = ref.watch(userServiceProvider);

    void _submit() {
      final User user = User(
          email: _teEmail.text,
          name: _teName.text,
          phone: _tePhone.text,
          address: Address(
              postalCode: _teCEP.text,
              address: _teAddress.text,
              complement: _teComplement.text,
              state: LocationState.State(_teState.text, '')));
      userService.create(user).then((value) {
        // TODO fazer algo apos user ser criado
      });
    }

    return SingleChildScrollView(
        child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text("Crie uma conta"),
          MainTextInput("Nome", "Digite seu nome completo", _teName),
          MainTextInput("Email", "Digite seu email", _teEmail),
          MainTextInput("Senha", "Digite sua senha", _tePassword),
          MainTextInput("Confirmar sua senha", "Confirme sua senha",
              _tePasswordConfirmation),
          MainTextInput("Telefone", "Digite seu telefone", _tePhone),
          MainTextInput("CEP", "Digite seu CEP", _teCEP),
          MainTextInput("Rua", "Rua e número", _teAddress),
          MainTextInput("Complemento", "Apartamento, bloco", _teComplement),
          MainDropdown(_states, "Selecione um Estado", "Estado", _teState),
          MainTextArea("Bio", "Fale um pouco sobre você", _teBio),
          Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: ElevatedButton(
                  onPressed: () => _submit(), child: const Text("Continuar"))),
        ])));
  }
}
