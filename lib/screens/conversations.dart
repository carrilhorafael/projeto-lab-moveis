import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/message.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/screens/chat.dart';

class Conversations extends ConsumerStatefulWidget {
  Conversations({Key? key}) : super(key: key);
  final User currentUser = AuthService.currentUser()!;

  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends ConsumerState<Conversations> {
  static List<Interest> _interests = [];
  static List<Message> _lastMessages = [];
  static List<User> _users = [];

  @override
  void initState() {
    super.initState();

    () async {
      final petService = ref.read(petServiceProvider);
      final userService = ref.read(userServiceProvider);
      final interestService = ref.read(interestServiceProvider);

      final interests = await interestService.findInterests(widget.currentUser);
      List<Message> lastMessages = [];
      List<User> users = [];

      // my interests
      {
        for (final interest in interests) {
          final chatService = ref.read(chatServiceProvider);
          final lastMessage = await chatService.lastMessage(interest) ??
              Message(interestId: "", content: "");

          lastMessages.add(lastMessage);
        }

        for (final interest in interests) {
          try{
            final pet = await petService.find(interest.petId);
            final user = await userService.find(pet.ownerId);

            users.add(user);
          }catch(e){
            print(e);
          }
        }
      }

      // interests on my pets
      {
        final myPets = await petService.ownedBy(widget.currentUser.id);

        for (final pet in myPets) {
          final petInterests = await interestService.findInteressed(pet);
          interests.addAll(petInterests);

          for (final interest in petInterests) {
            final chatService = ref.watch(chatServiceProvider);
            final lastMessage = await chatService.lastMessage(interest) ??
                Message(interestId: "", content: "");

            lastMessages.add(lastMessage);
          }

          for (final interest in petInterests) {
            final user = await userService.find(interest.userId);
            users.add(user);
          }
        }
      }

      if (!this.mounted) return;

      setState(() {
        _interests = interests;
        _lastMessages = lastMessages;
        _users = users;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: _interests.length,
                    itemBuilder: (context, index) {
                      print(_interests.length);
                      print(_users.length);
                      print(index);
                      if (_lastMessages.length == 0 || _users.length == 0) {
                        return Text("Carregando ...");
                      }
                      Interest interest = _interests[index];

                      Message lastMessage = _lastMessages[index];
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Material(
                              child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Chat(interest, _users[index % 3])));
                            },
                            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text(_users[index % 3].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            subtitle: Text(lastMessage.content,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14)),
                          )));
                    }))));
  }
}
