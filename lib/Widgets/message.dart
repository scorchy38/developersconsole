import 'package:chat_list/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Message extends StatefulWidget {
  double pWidth;
  Message({this.pWidth});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Color(0xFF970101),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: FittedBox(
              child: Text(
                'A',
                style: GoogleFonts.k2d(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
