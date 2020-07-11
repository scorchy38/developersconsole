import 'package:developersconsole/Widgets/profile_card.dart';
import 'package:developersconsole/classes/developer_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DevelopersList extends StatefulWidget {
  String userPhNo;
  DevelopersList({this.userPhNo});
  @override
  _DevelopersListState createState() => _DevelopersListState();
}

List<Developer> recentlyContacted = new List();
List<Developer> newContacts = new List();
List<Developer> allContacts = new List();
List<ProfileCard> allPeopleCards = new List();
DatabaseReference ref = FirebaseDatabase.instance.reference();
DatabaseReference usersRef = ref.child('Members');
var _isloaded = false;

class _DevelopersListState extends State<DevelopersList> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF970101),
        title: Text(
          'Console.developer\'s',
          style: GoogleFonts.k2d(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Developers',
                style: GoogleFonts.k2d(
                    fontSize: 34,
                    color: Color(0xFF970101),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Container(
                  child: StreamBuilder(
                stream: usersRef.onValue,
                builder: (context, snap) {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                    Map data = snap.data.snapshot.value;
                    List item = [];

                    data.forEach(
                        (index, data) => item.add({"key": index, ...data}));
                    allContacts.clear();
                    for (var i in item) {
                      if (i['key'] != widget.userPhNo) {
                        allContacts.add(Developer(
                            name: i['Name'],
                            category: i['Category'],
                            phone: i['key']));
                      }
                    }
                    return ListView.builder(
                      itemCount: allContacts.length,
                      itemBuilder: (context, index) {
                        return ProfileCard(
                            dev: allContacts[index], userPhNo: widget.userPhNo);
                      },
                    );
                  } else
                    return Text("No data");
                },
              )),
            ),
            Container(
                child: ProfileCard(
                    dev: Developer(
                        name: 'Owner', category: 'Head', phone: '12121212'))),
            SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
