import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart';
import 'package:projeto_lab/domain/entities/message.dart';
import 'package:projeto_lab/domain/entities/pet.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/domain/services/user_service.dart';
import 'package:projeto_lab/providers.dart';
import 'package:projeto_lab/screens/chat.dart';

class Conversations extends ConsumerStatefulWidget {
  Conversations({Key? key}) : super(key: key);
  User current_user = AuthService.currentUser()!;

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
      final service = ref.read(interestServiceProvider);
      final interests = await service.findInterests(widget.current_user);
      List<Message> lastMessages = [];
      List<User> users = [];

      for (final interest in interests){
        final chatService = ref.read(chatServiceProvider);
        final lastMessage = await chatService.lastMessage(interest);

        lastMessages.add(lastMessage);
      }

      for (final interest in interests){
        // final pet = await petService.find(interest.petId);
        final userService = ref.read(userServiceProvider);
        final user = await userService.find(interest.userId);

        users.add(user);
      }

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
              Interest interest = _interests[index];
              if (_lastMessages.length == 0 || _users.length == 0) {
                return Text("Carregando ...");
              }

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
                          builder: (context) => Chat(interest, _users[index])
                        )
                      );
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(_users[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(lastMessage.content,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey, fontSize: 14)),
                      )
                    )
                  );
                }
              )
            )
          )
        );
  }
}
