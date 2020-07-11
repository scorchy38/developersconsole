import 'package:developersconsole/Screens/chat.dart';
import 'package:developersconsole/classes/developer_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatefulWidget {
  Developer dev;
  String userPhNo;
  ProfileCard({this.dev, this.userPhNo});
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

TextEditingController controller = new TextEditingController();

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Chat(dev: widget.dev, userPhNo: widget.userPhNo)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ListTile(
          title: Text(
            widget.dev.name,
            style: GoogleFonts.k2d(fontSize: 20),
          ),
          subtitle: Text(widget.dev.category),
        ),
      ),
    );
  }
}
