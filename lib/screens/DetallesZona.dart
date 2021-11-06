import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/ValoracionesReporteAtributo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ValorarDeporte.dart';

Future<void> detallesZona(BuildContext ctx, ZonaDeportiva zonaDeportiva) async {
  print(zonaDeportiva.toString());
  return showDialog<void> (
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog (
            title: Text(zonaDeportiva.nombre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center ),
            content: SingleChildScrollView(
                child: ListBody(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Tooltip(child:Icon(Icons.sports_soccer,
                        color: zonaDeportiva.deportes.contains("futbol")?Colors.orange:Colors.black12),
                        message: "Futbol"),
                    Tooltip(child:Icon(Icons.sports_basketball,
                        color: zonaDeportiva.deportes.contains("basquetbol")?Colors.orange:Colors.black12),
                        message: "Basketball"),
                    Tooltip(child:Icon(Icons.fitness_center,
                        color: zonaDeportiva.deportes.contains("calistenia")?Colors.orange:Colors.black12),
                        message: "Calistenia"),//Calistenia?
                    Tooltip(child:Icon(Icons.sports_tennis,
                        color: zonaDeportiva.deportes.contains("tenis")?Colors.orange:Colors.black12),
                        message: "Tenis"),
                    Tooltip(child:Icon(Icons.skateboarding,
                        color: zonaDeportiva.deportes.contains("skate")?Colors.orange:Colors.black12),
                        message: "Skateboard"),
                    ],
                  ),
                  SizedBox(height:20, width:0),
                  Text(zonaDeportiva.descripcion, style: TextStyle(fontStyle: FontStyle.italic)),
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
                  Text("Reportes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fútbol ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left ),
                      MaterialButton(onPressed: (){valorarDeporte(ctx, "Futbol");}, child: Text("VALORAR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))),
                    ],
                  ),
                  ValoracionEspacio(texto: "Iluminación", valor: 3.0),
                  ValoracionEspacio(texto: "Implementos", valor: 2.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Basquetbol", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left ),
                      MaterialButton(onPressed: (){valorarDeporte(ctx, "Basquetbol");}, child: Text("VALORAR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))),
                    ],
                  ),
                  ValoracionEspacio(texto: "Iluminación", valor: 3.0),
                  ValoracionEspacio(texto: "Implementos", valor: 5.0),
                ]
                )
            ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation:32,

        );
      }
  );
}