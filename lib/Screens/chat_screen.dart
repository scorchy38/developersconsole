import 'package:chat_list/chat_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final String recieverID = 'shubhsaras';

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageWidget> _messageList = [
    MessageWidget(
        content: "Hi, Bill! This is the simplest example ever.",
        ownerType: OwnerType.sender,
        ownerName: "Higor Lapa"),
    MessageWidget(
        content:
            "Let's make it better , Higor. Custom font size and text color",
        textColor: Colors.black38,
        fontSize: 18.0,
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "Bill, we have to talk about business",
        fontSize: 12.0,
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Wow, I like it. Tell me what I can do for you, pal.",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Nice", ownerType: OwnerType.sender, ownerName: "Higor"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    MessageWidget(
        content: "Nice", ownerType: OwnerType.sender, ownerName: "Higor"),
    MessageWidget(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
  ];
  TextEditingController controller = new TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    DatabaseReference newRef = ref.child('messages');
    newRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var DATA = snap.value;

      for (var key in keys) {
        print(DATA[key]['text']);
        _messageList.add((MessageWidget(
          content: DATA[key]['text'],
          ownerType: OwnerType.receiver,
          ownerName: 'Avi',
        )));
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: ChatList(children: _messageList)),
            Container(
              width: double.infinity,
              height: 80,
              color: Colors.black,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: TextField(
                            controller: controller,
                            decoration:
                                InputDecoration(hintText: 'Enter Message'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    color: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (controller.text != null) {
                          ref.child('messages').push().set({
                            'Text': controller.text,
                            'Sender': '6398256972',
                            'Time Stamp': DateTime.now().toString(),
                            'Reciever': '6398415557'
                          });
                        } else {
                          print('No Message');
                        }
                        print('object');
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
