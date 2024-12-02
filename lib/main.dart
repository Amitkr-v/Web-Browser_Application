import 'package:browser/Pages/Afters.dart';
import 'package:browser/Pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
          primarySwatch: Colors.amber,
        fontFamily: GoogleFonts.poppins().fontFamily),
      initialRoute: '/',
      routes: {
        '/': (context) => Splash1(),
      
      },
    );
  }
}
