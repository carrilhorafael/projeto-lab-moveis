import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projeto_lab/domain/entities/Interest.dart';
import 'package:projeto_lab/domain/entities/message.dart';
import 'package:projeto_lab/domain/entities/user.dart';
import 'package:projeto_lab/domain/services/auth_service.dart';
import 'package:projeto_lab/providers.dart';

class Chat extends ConsumerStatefulWidget {
  User current_user = AuthService.currentUser()!;
  Interest interest;
  User owner;
  Chat(this.interest, this.owner);

  @override
  _ChatState createState() => _ChatState();
}
class _ChatState extends ConsumerState<Chat> {
  TextEditingController _controllerMessage = TextEditingController();
  List<Message> _messages = [];

  listener(message) {
    // print(message);
    setState(() {
      _messages.add(message);
    });
  }

  void initState() {
    super.initState();

    () async {
      final service = ref.read(chatServiceProvider);
      final messages = await service.messages(widget.interest, listener);

      setState(() {
        _messages = messages;
      });
    }();
  }

  _sendMessage() async {
    Message message = new Message(interestId: widget.interest.id, content: _controllerMessage.text);
    message.senderId =  widget.current_user.id;

    final service = ref.read(chatServiceProvider);
    await service.send(message);
    _controllerMessage.text = "";
  }

  Widget build(BuildContext context) {
    var messageBox = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMessage,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  hintText: "Digite uma mensagem...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
                ),
              )
            )
          ),
          FloatingActionButton(
            onPressed: _sendMessage,
            backgroundColor: Color(0xff4CAF50),
            child: Icon(Icons.send, color: Colors.white),
          )
        ],
      ),
    );

    var listView = Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (context, index){
          Message message = _messages[index];

          return Align(
            alignment: message.isFrom(widget.current_user) ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: message.isFrom(widget.current_user) ? Color(0xff7B61FF) : Color(0xffE5E5E5),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Text(
                  message.content,
                  style: TextStyle(
                    color: message.isFrom(widget.current_user) ? Colors.white : Colors.black
                  )
                ),
              ),
            ),
          );
        }
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text(widget.owner.name),
          IconButton(
            onPressed: () {
              print('Abrir o mapa desse usuário');
            },
            icon: Icon(Icons.map_outlined)
          )
        ])
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                listView,
                messageBox
              ],
            )
          )
        )
      )
    );
  }
}
