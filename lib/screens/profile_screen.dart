import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart'
    as AddressState;
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final User user;

  ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? _url;
  @override
  void initState() {
    super.initState();

    final service = ref.read(userServiceProvider);
    // ignore: unnecessary_statements
    () async {
      final url = await service.fetchImageURL(widget.user.id);
      setState(() {
        this._url = url;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Row(children: [
          ClipOval(
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _url != null
                        ? Image.network(_url!).image
                        : AssetImage('images/userProfilePic.jpg'),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                  ),
                )),
          ),
          SizedBox(width: 10),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.user.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19)))
        ]),
        SizedBox(height: 25),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Email',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.email,
                style: TextStyle(fontSize: 14, color: Colors.white)))),
        SizedBox(height: 25),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Contato',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.phone,
                style: TextStyle(fontSize: 14, color: Colors.white)))),
        SizedBox(height: 25),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Bio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.description,
                style: TextStyle(fontSize: 14, color: Colors.white)))),
        SizedBox(
            width: width * 0.9,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.white))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent)),
              child: Text('Editar Perfil',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                // TODO Caminho para a tela Editar Perfil
              },
            )),
        SizedBox(
            width: width * 0.9,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Meus Pets',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                // TODO Caminho para a tela Meus Pets
              },
            ))
      ])),
    );
  }
}
