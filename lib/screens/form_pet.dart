import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'components/main_text_area.dart';
import 'components/main_text_input.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';

// DESCRIPTION: Widget da página de formulário de criação de novos pets atrelados ao usuário logado.
class PetFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: PetForm()
                  ));
  }
}
// Widget do tipo stateful do fomulário de cadastro
class PetForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PetFormState();
  }
}

// Estado do formulário de cadastro, contem os campos
// para instancia um modelo de Pet localmente que será
// enviado para o serviõ do firebase
class _PetFormState extends ConsumerState<PetForm> {
  final _teName = TextEditingController();
  final _teAge = TextEditingController();
  final _teRace = TextEditingController();
  final _teSpecies = TextEditingController();
  final _teDescription = TextEditingController();

  String? _imagePath;
  Size? _size;

  @override
  Widget build(BuildContext context) {
    // Criação da lista de  itens do dropdown de tamanhos
    final _sizes = Size.values.map((Size e) {
      return DropdownMenuItem<Size>(
        child: Text("${describeEnum(e)}"),
        value: e,
      );
    }).toList();

    final petService = ref.watch(petServiceProvider);
    // Metodo que cria uma instancia de Pet e envia para
    // o back-end utilizando petService.create()
    void _create() {
      final Pet pet = new Pet(
        ownerId: AuthService.currentUser()!.id,
        name: _teName.value.text,
        description: _teDescription.value.text,
        species: _teSpecies.value.text,
        race: _teRace.value.text,
        size: _size!,
        age: int.parse(_teAge.value.text),
      );

      petService.create(pet).then((_) async {
        await petService.uploadImage(pet.id, File(_imagePath!));
        Navigator.pop(context);
      }).onError((e, _) {
        print(e);
      });
    }

    return SingleChildScrollView(
        child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image =
                    await picker.pickImage(source: ImageSource.gallery);
                _imagePath = image!.path;
              },
              child: const Text("Selecionar Foto")),
          MainTextInput("Nome", "Digite o nome do pet", _teName),
          MainTextInput("Idade", "Digite a idade do pet", _teAge),
          MainTextInput("Especie", "Digite a especie", _teSpecies),
          MainTextInput("Raça", "Digite a raça", _teRace),
          SizeDropdown(_sizes, "Selecione um Tamanho", "Tamanho", (size) {
            setState(() {
              _size = size;
            });
          }),
          MainTextArea("Bio", "Fale um pouco sobre o pet", _teDescription),
          Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 86.0, 8.0, 8.0),
              child: ElevatedButton(
                  onPressed: () => _create(), child: const Text("Salvar"))),
        ])));
  }
}

class SizeDropdown extends StatelessWidget {
  final List<DropdownMenuItem<Size>> _items;
  final String _hint;
  final String _label;
  final void Function(Size?) onChanged;

  SizeDropdown(this._items, this._hint, this._label, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(_label),
        DropdownButtonFormField<Size>(
          items: _items,
          onChanged: onChanged,
          hint: Text(_hint),
        ),
      ],
    ));
  }
}
