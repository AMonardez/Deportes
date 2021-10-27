import 'package:deportes/widgets/ValoracionesEspacio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> detallesEspacio(BuildContext ctx) async {
  return showDialog<void> (
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog (
            title: Text("Nombre Lugar Deportivo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center ),
            content: SingleChildScrollView(
                child: ListBody(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Tooltip(child:Icon(Icons.sports_soccer, color: Colors.orange),message: "Futbol"),
                    Tooltip(child:Icon(Icons.sports_basketball, color: Colors.orange), message: "Basketball"),
                    Tooltip(child:Icon(Icons.fitness_center, color: Colors.orange), message: "Calistenia"),//Calistenia?
                    Tooltip(child:Icon(Icons.sports_tennis, color: Colors.orange), message: "Tenis"),
                    Tooltip(child:Icon(Icons.skateboarding, color: Colors.orange), message: "Skateboard"),
                    ],
                  ),
                  SizedBox(height:20, width:0),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", style: TextStyle(fontStyle: FontStyle.italic)),
                  Padding(
                    padding: EdgeInsets.only(left:0, right: 0, top: 20, bottom:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Placeholder(fallbackHeight: 50, fallbackWidth: 50,color: Colors.orange),
                        Placeholder(fallbackHeight: 50, fallbackWidth: 50,color: Colors.redAccent),
                        Placeholder(fallbackHeight: 50, fallbackWidth: 50,color: Colors.blueAccent),
                        Placeholder(fallbackHeight: 50, fallbackWidth: 50,color: Colors.lightGreen)
                      ]
                    ),
                  ),
                  Text("Valoraciones", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.left ),

                  ValoracionEspacio(texto: "Iluminación", valor: 3.0),
                  ValoracionEspacio(texto: "Areas Verdes", valor: 5.0),
                  ValoracionEspacio(texto: "Seguridad", valor: 2.0),
                ]
                )
            ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation:32,

        );
      }
  );
}