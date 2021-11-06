import 'package:deportes/screens/MapaZonasDeportivas.dart';
import 'package:deportes/widgets/MapaMarcadores.dart';
import 'package:deportes/widgets/MapaAgregar.dart';
import 'package:deportes/widgets/MenuAnvorgueso.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
        primarySwatch: Colors.green,
        fontFamily: GoogleFonts.jost().fontFamily,
        textTheme: GoogleFonts.jostTextTheme()
      ),
      home: MapaZonasDeportivas(),
      initialRoute: "espacios_deportivos",
    );
  }
}