import 'package:deportes/screens/MapaZonasDeportivas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Espacios Deportivos',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: GoogleFonts.jost().fontFamily,
        textTheme: GoogleFonts.jostTextTheme()
      ),
      home: MapaZonasDeportivas(),
      initialRoute: "espacios_deportivos",
    );
  }
}