import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart'
    as AddressState;
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/screens/my_pets.dart';

class ProfilePage extends ConsumerStatefulWidget {
  //Classe para mostrar o perfil de usuário
  final User user;
  //Recebe como argumento o usuário atual
  ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String? _url;
  @override
  void initState() {
    //Declara o estado inicial puxando a imagem de usuário do firebase
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
  //Constrói o Widget
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; //lê o tamanho da tela
    double width = screenSize.width; //lê a largura da tela

    return Scaffold(
      backgroundColor: Colors.transparent, //seta o backgrond transparente
      body: SingleChildScrollView( //utiliza um widget do tipo singlechildScrollView
          child: Column(children: <Widget>[ //Adiciona um widget do tipo coluna
        Row(children: [
          ClipOval( //Usa um widget do tipo clipOval para arredondar a imagem de perfil
            child: Container(
                width: 80,  //Define a largura e altura da imagem
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage( //DecorationImage para mostrar a imagem
                    image: _url != null
                        ? Image.network(_url!).image
                        : AssetImage('images/userProfilePic.jpg'), //Fornece o caminho da imagem
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                  ),
                )),
          ),
          SizedBox(width: 10), //Adiciona 10 de espaço
          Align( //Adiciona o nome de usuário
              alignment: Alignment.centerLeft,
              child: Text(widget.user.name, //Nome do usuário
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19)))
        ]),
        SizedBox(height: 25), //Adiciona um espaçamento
        Align( //Adiciona a palavra 'Email'
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Email',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align( //Adiciona o email do usuário
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.email, //Email do usuário
                style: TextStyle(fontSize: 14, color: Colors.white)))),
        SizedBox(height: 25), //Adiciona espaçamento
        Align( //Adiciona a palavra 'Contato'
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Contato',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align( //Adiciona o telefone do usuário
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.phone, //Telefone do usuário
                style: TextStyle(fontSize: 14, color: Colors.white)))),
        SizedBox(height: 25), //Adiciona espaçamento
        Align( //Adiciona a palavra 'Bio'
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: 'Bio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
        Align( //Adiciona a descrição do usuário
            alignment: Alignment.centerLeft,
            child: Text.rich(TextSpan(
                text: widget.user.description, //Descrição do usuário
                style: TextStyle(fontSize: 14, color: Colors.white)))),

        //Adiciona um botão para Editar Perfil
        SizedBox( //Define um SizedBox para conectar o tamanho do botão a largura da tela
            width: width * 0.9, //Tamanho do botão 90% da largura da tela
            child: TextButton( //Cria um botão retangular com bordas arredondadas
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
              onPressed: () { //Função conectada ao botão Editar Perfil
                // TODO Caminho para a tela Editar Perfil
              },
            )),

        //Adiciona um botão para ir para a página Meus Pets
        SizedBox( //Define um SizedBox com 90% de largura da tela
            width: width * 0.9,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Meus Pets', //Define o botão meus pets
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),

              //Função conectada ao botão Meus Pets
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => MyPetsScreen()));
              },
            ))
      ])),
    );
  }
}
