import 'package:deportes/widgets/ValoracionesReporteAtributo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> valorarDeporte(BuildContext ctx, String deporte) async {
  //String deporte= "Fútbol";

  return showDialog<void> (
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog (
            title: Text("$deporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center ),
            content: SingleChildScrollView(
                child: ListBody(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Tooltip(child:Icon(Icons.sports_soccer, color: Colors.orange),message: "Futbol"),
                    Tooltip(child:Icon(Icons.sports_basketball, color: Colors.orange), message: "Basketball"),
                    Tooltip(child:Icon(Icons.fitness_center, color: Colors.black12), message: "Calistenia"),//Calistenia?
                    Tooltip(child:Icon(Icons.sports_tennis, color: Colors.black12), message: "Tenis"),
                    Tooltip(child:Icon(Icons.skateboarding, color: Colors.black12), message: "Skateboard"),
                    ],
                  ),

                ]
                )
            ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation:32,

        );
      }
  );
}