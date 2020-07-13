import 'package:developersconsole/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

TextEditingController phoneNo = new TextEditingController();
TextEditingController password = new TextEditingController();
DatabaseReference ref = FirebaseDatabase.instance.reference().child('Members');

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double pWidth = MediaQuery.of(context).size.width;
    double pHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: pHeight * 0.6,
                width: pWidth * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF970101), Colors.black])), //970101
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: pHeight * 0.06,
                    ),
                    Text('Developer Console',
                        style: GoogleFonts.k2d(
                            fontSize: pHeight * 0.035,
                            color: Colors.white.withOpacity(0.8))),
                    SizedBox(
                      height: pHeight * 0.05,
                    ),
                    Container(
                      height: pHeight * 0.05,
                      width: pWidth * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          controller: phoneNo,
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            fillColor: Colors.black,
                            hoverColor: Colors.black,
                            hintText: 'Enter Phone Number',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.025,
                    ),
                    Container(
                      height: pHeight * 0.05,
                      width: pWidth * 0.6,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            fillColor: Colors.black,
                            hoverColor: Colors.black,
                            hintText: 'Enter Password',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        ref.once().then((DataSnapshot snap) {
                          var keys = snap.value.keys;
                          var DATA = snap.value;

                          for (var key in keys) {
                            if (phoneNo.text == key &&
                                password.text == DATA[key]["Password"]) {
                              print('Mil gya boss');
                              changeLoginStatus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainHome(userPhNo: phoneNo.text)),
                              );
                            } else
                              print('User not found');
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: pHeight * 0.05,
                        width: pWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 2, color: Colors.white.withOpacity(0.8)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Enter',
                          style: GoogleFonts.k2d(
                              fontSize: pHeight * 0.025,
                              color: Colors.white.withOpacity(0.8)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: pHeight * 0.2,
                child: Image.asset('assets/logo_red.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

changeLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('status', 'LoggedIn');
  prefs.setString('phoneNumber', phoneNo.text);
  print('Updated');
}
