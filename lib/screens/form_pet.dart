import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/pet.dart';

class PetFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Adicionar Pet"),
              PetForm()
            ]
        )
      )
    );
  }
}

class PetForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PetFormState();
  }
}

class _PetFormState extends ConsumerState<PetForm>  { 
  final _teName = TextEditingController();
  final _teAge = TextEditingController();
  final _teRace = TextEditingController();
  final _teSpecies = TextEditingController();
  final _teSize = TextEditingController();
  final _teDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _sizes = ['small', 'medium', 'big'].map((e) {
      return DropdownMenuItem<Size>(
        child: Text(e),
        value: Size.e,
      );
    }).toList();

    void _submit() { 
      final Pet user = new Pet(
        ownerId: this.ownerId,
        name: _teName.value,
        description: _teDescription.value,
        species: _teSpecies.value,
        race: _teRace.value,
        size: _teSize.value,
        age: int.tryParse(_teAge.value),
      );
      // Service.register().then((_) async {
      //   final Service = ref.read();
      //   assert(AuthService.currentUser() != null);
      //   Navigator.pop(context);
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TabView()));
      // }).onError((e, _) {print(e)});
    }

    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Crie uma conta"),
            MainTextInput("Nome", "Digite o nome do pet", _teName),
            MainTextInput("Especie", "Digite seu email", _teSpecies),
            MainTextInput("Raça", "Digite sua senha", _teRace),
            SizeDropdown(_sizes, "Selecione um Tamanho", "Tamanho", (size) {
              setState(() {_size = size;});
            }),
            MainTextArea("Bio", "Fale um pouco sobre o pet", _teDescription),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
              child: ElevatedButton(
                onPressed: () => _submit(), 
                child: const Text("Salvar")
              )
            ),
          ]
        )
      )
    );
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
      )
    );
  }
}