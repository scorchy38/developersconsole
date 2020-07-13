import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF970101),
        title: Text(
          'Console.developer\'s',
          style: GoogleFonts.k2d(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Container(
        color: Colors.black87,
      ),
    );
  }
}
