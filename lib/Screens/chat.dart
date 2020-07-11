import 'package:bubble/bubble.dart';
import 'package:chat_list/chat_list.dart';
import 'package:developersconsole/Widgets/message.dart';
import 'package:developersconsole/classes/developer_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class Chat extends StatefulWidget {
  Developer dev;
  String userPhNo;
  Chat({this.dev, this.userPhNo});
  @override
  _ChatState createState() => _ChatState();
}

DatabaseReference ref = FirebaseDatabase.instance.reference();
TextEditingController controller = new TextEditingController();

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference newRef = ref.child('messages');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF970101),
        title: Text(widget.dev.name),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<Event>(
            stream: newRef.onValue,
            builder: (context, snap) {
              if (snap.hasData &&
                  !snap.hasError &&
                  snap.data.snapshot.value != null) {
                Map data = snap.data.snapshot.value;
                List item = [];

                data.forEach(
                    (index, data) => item.add({"key": index, ...data}));
                List messages = [];
                for (var msg in item) {
                  if ((msg['Sender'] == widget.dev.phone &&
                          msg['Reciever'] == widget.userPhNo) ||
                      (msg['Reciever'] == widget.dev.phone &&
                          msg['Sender'] == widget.userPhNo)) {
                    messages.add(msg);
                  }
                }
                Comparator timeComparator =
                    (a, b) => b['Time Stamp'].compareTo(a['Time Stamp']);
                messages.sort(timeComparator);

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index]['Sender'] == widget.userPhNo
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Bubble(
                              alignment: Alignment.centerRight,
                              nip: BubbleNip.rightTop,
                              child: Text(messages[index]['Text']),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Bubble(
                              alignment: Alignment.centerLeft,
                              nip: BubbleNip.leftTop,
                              child: Text('adsss'),
                            ),
                          );
                  },
                );
              } else
                return Text("No data");
            },
          )),
          Container(
            height: 80,
            color: Colors.black,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 17),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF970101),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white.withOpacity(0.5)),
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Enter Message',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            var now = await NTP.now();
                            if (controller.text != null) {
                              ref.child('messages').push().set({
                                'Text': controller.text,
                                'Sender': widget.userPhNo,
                                'Time Stamp': now.toString(),
                                'Reciever': widget.dev.phone
                              }).then((value) => controller.clear());
                            } else {
                              print('No Message');
                            }
                            print(now.toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 5,
            color: Colors.transparent,
          )
        ],
      )),
    );
  }
}
