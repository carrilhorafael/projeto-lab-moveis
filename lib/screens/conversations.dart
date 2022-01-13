import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/location/address.dart';
import 'package:projeto_lab/domain/entities/location/state.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/screens/chat.dart';


class Conversations extends ConsumerStatefulWidget {
  Conversations({Key? key}) : super(key: key);

  @override
  _ConversationsState createState() => _ConversationsState();
}

class Conversation {
  final User recipient;
  List<Message> messages;

  Conversation({
    required this.recipient,
    required this.messages,
  });

  Message last(){
    return messages[messages.length-1];
  }
}

class Message {
  final String content;
  final User sender;

  Message({
    required this.content,
    required this.sender,
  });
}

class _ConversationsState extends ConsumerState<Conversations> {

  static List<Conversation> _conversations = [
    Conversation(
        recipient: _recipients[0],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[0]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[0]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[1],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[1]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[1]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[2],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[2]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[2]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[3],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[3],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[3],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    ),
    Conversation(
        recipient: _recipients[3],
        messages: [
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
          Message(content: "Uma mensagem legal", sender: _recipients[3]),
          Message(content: "Uma mensagem legal", sender: myUser),
        ]
    )
  ];

  static User myUser = User(
    name: "Eduardo Canellas",
    email: "eduado@email.com",
    phone: "(21)98888-8888",
    description: "Um dev muito legal",
    address: Address(
        postalCode: "22222-000",
        address: "Rua dos Devs, 32, Niteroi",
        complement: "Casa 1",
        state: State("Rio de Janeiro","RJ")
    )
  );

  static List<User> _recipients = [
    User(
      name: "Eduardo Canellas",
      email: "eduado@email.com",
      phone: "(21)98888-8888",
      description: "Um dev muito legal",
      address: Address(
          postalCode: "22222-000",
          address: "Rua dos Devs, 32, Niteroi",
          complement: "Casa 1",
          state: State("Rio de Janeiro","RJ")
      )
    ),
    User(
      name: "Rafael Kanazawa",
      email: "kana@email.com",
      phone: "(21)98888-8888",
      description: "Um dev muito legal",
      address: Address(
          postalCode: "22222-000",
          address: "Rua dos Devs, 32, Niteroi",
          complement: "Casa 1",
          state: State("Rio de Janeiro","RJ")
      )
    ),
    User(
      name: "Gyselle Mello",
      email: "gyselle@email.com",
      phone: "(21)98888-8888",
      description: "Um dev muito legal",
      address: Address(
          postalCode: "22222-000",
          address: "Rua dos Devs, 32, Niteroi",
          complement: "Casa 1",
          state: State("Rio de Janeiro","RJ")
      )
    ),
    User(
      name: "Ricardo",
      email: "ricardo@email.com",
      phone: "(21)98888-8888",
      description: "Um dev muito legal",
      address: Address(
          postalCode: "22222-000",
          address: "Rua dos Devs, 32, Niteroi",
          complement: "Casa 1",
          state: State("Rio de Janeiro","RJ")
      )
    ),
    User(
      name: "Brunin",
      email: "brunin@email.com",
      phone: "(21)98888-8888",
      description: "Um dev muito legal",
      address: Address(
          postalCode: "22222-000",
          address: "Rua dos Devs, 32, Niteroi",
          complement: "Casa 1",
          state: State("Rio de Janeiro","RJ")
      )
    )
  ];

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container (
          alignment: Alignment.topLeft,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: _conversations.length,
            itemBuilder: (context, index) {
              Conversation conversa = _conversations[index];
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
                          MaterialPageRoute(builder: (context) => Chat())
                      );
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      conversa.recipient.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      )
                    ),
                    subtitle: Text(
                      conversa.last().content,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      )
                    ),
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
