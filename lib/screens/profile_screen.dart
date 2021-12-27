import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_lab/screens/search_settings.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart' as AddressState;
//import 'package:projeto_lab/providers.dart';



/*
class Animal {
  final int id;
  final String name;

  Animal(int id,String name){
    final this.id = 0;
    this.id = id;
    this.name = name;
  };
}
*/
class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  User currentUser = User(id: "0", name: "João da Silva", address: Address(postalCode: "20111-111",
      address: "Rua 1, Icaraí, Niterói", complement: "Ap 101",state: AddressState.State("Rio de Janeiro", "RJ")),
      email: "joao@dasilva.com", phone: "2199999-9999",description: "Lorem ipsum amet dolor Lorem ipsum amet dolor Lorem ipsum amet dolor");



  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(

          children: <Widget>[
            Row(children:[ClipOval(
                                child:
                                    Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('images/userProfilePic.jpg'),
                                            fit: BoxFit.cover,
                                            repeat: ImageRepeat.noRepeat,
                                          ),
                                        )),
                              ),
                              SizedBox(width: 10),

                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(currentUser.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19)))]
            ),


            SizedBox(height: 25),
            //################################################################################################
            // Rounded blue MultiSelectDialogField
            //################################################################################################

            Align(alignment: Alignment.centerLeft, child:
              Text.rich(TextSpan(
                          text: 'Email',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white)))),
            Align(alignment: Alignment.centerLeft, child:
              Text.rich(TextSpan(
                  text: currentUser.email,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white)))),
            SizedBox(height: 25),
            Align(alignment: Alignment.centerLeft, child:
            Text.rich(TextSpan(
                text: 'Contato',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
            Align(alignment: Alignment.centerLeft, child:
            Text.rich(TextSpan(
                text: currentUser.phone,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white)))),
            SizedBox(height: 25),
            Align(alignment: Alignment.centerLeft, child:
            Text.rich(TextSpan(
                text: 'Bio',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white)))),
            Align(alignment: Alignment.centerLeft, child:
            Text.rich(TextSpan(
                text: currentUser.description,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white)))),
           //Align(alignment: Alignment.centerLeft, child:Text(currentUser.description)),
            SizedBox(
                width: width * 0.9,
                child: TextButton(
                          style: ButtonStyle(
                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side: BorderSide(color: Colors.white)
                                  )),
                              backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.transparent)),
                          child: Text('Editar Perfil',
                              style: TextStyle(color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            //Caminho para a tela Editar Perfil
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
                    //Caminho para a tela Meus Pets

                  },
                ))

            //################################################################################################
            // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
            // decoration applied. This allows the ChipDisplay to render inside the same Container.
            //################################################################################################

        ])
      ),
    );
  }
}
