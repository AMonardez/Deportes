import 'package:deportes/screens/AgregarEspacio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuAnvorgueso extends StatefulWidget{
  @override
  _MenuAnvorguesoState createState() => _MenuAnvorguesoState();
}

class _MenuAnvorguesoState extends State<MenuAnvorgueso> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Placeholder(fallbackWidth: 200, fallbackHeight: 100),
                Text("Espacios Deportivos")])
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text("Agregar Espacio Deportivo"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarEspacio()));
            },
          ),
        ]
      ),
    );
  }
}