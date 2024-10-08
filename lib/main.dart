import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/music_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Player(),
      theme: ThemeData(
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}