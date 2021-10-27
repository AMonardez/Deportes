import 'package:deportes/widgets/MapaVerEspacios.dart';
import 'package:deportes/widgets/MapaAgregar.dart';
import 'package:deportes/widgets/menu_anvorgueso.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Espacios Deportivos en tu Ciudad", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: MenuAnvorgueso(),
      body: Center(
        child: MapaDeporte(),
      ),
    );
  }
}
