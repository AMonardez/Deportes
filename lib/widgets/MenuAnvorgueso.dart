import 'package:deportes/screens/AgregarEspacio.dart';
import 'package:deportes/screens/TestLoc.dart';
import 'package:deportes/screens/TestPermission.dart';
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
          Container(
            height:270,
            child: DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', width:200, height:200),
                    //Icon(Icons.location_city_sharp, size: 100,),
                  Text("Zonas Deportivas")])
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_location_alt, color: Theme.of(context).accentColor),
            title: Text("Agregar Zona Deportiva"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AgregarEspacio()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.check, color: Theme.of(context).accentColor),
            title: Text("Location StreamListener test"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListenLocationWidget()));
            },
          ),
          ListTile(
            leading: Icon(Icons.check, color: Theme.of(context).accentColor),
            title: Text("LocationPermission test"),
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionStatusWidget()));
            },
          ),
        ]
      ),
    );
  }
}