import 'package:deportes/widgets/MapaMarcadores.dart';
import 'package:deportes/widgets/MenuAnvorgueso.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapaZonasDeportivas extends StatelessWidget {
  const MapaZonasDeportivas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Espacios Deportivos en tu Ciudad", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        foregroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: MenuAnvorgueso(),
      body: Center(
        child: MapaMarcadores(),
      ),
    );
  }
}