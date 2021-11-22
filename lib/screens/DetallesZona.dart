import 'dart:convert';

import 'package:deportes/api/valoraciones_deportes.dart';
import 'package:deportes/models/Reporte.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/FilaImagenes.dart';
import 'package:deportes/widgets/ReporteDeporte.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> detallesZona(BuildContext ctx, ZonaDeportiva zonaDeportiva) async {
  print("ZonaDeportiva: "+ jsonEncode(zonaDeportiva));
  //Future<List<Reporte>> frp = Future.delayed(Duration(seconds:3), ()=>Reporte.reportesDePrueba(zonaDeportiva.deportes) );
  Future<List<Reporte>> frp = ValoracionesApi.getReportes(zonaDeportiva);
  Color colorDestacado= Theme.of(ctx).accentColor;
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
                        color: zonaDeportiva.deportes.contains("futbol")?colorDestacado:Colors.black12),
                        message: "Futbol"),
                    Tooltip(child:Icon(Icons.sports_basketball,
                        color: zonaDeportiva.deportes.contains("basquetbol")?colorDestacado:Colors.black12),
                        message: "Basketball"),
                    Tooltip(child:Icon(Icons.fitness_center,
                        color: zonaDeportiva.deportes.contains("calistenia")?colorDestacado:Colors.black12),
                        message: "Calistenia"),//Calistenia?
                    Tooltip(child:Icon(Icons.sports_tennis,
                        color: zonaDeportiva.deportes.contains("tenis")?colorDestacado:Colors.black12),
                        message: "Tenis"),
                    Tooltip(child:Icon(Icons.skateboarding,
                        color: zonaDeportiva.deportes.contains("skate")?colorDestacado:Colors.black12),
                        message: "Skateboard"),
                    ],
                  ),
                  SizedBox(height:8, width:0),
                  /*Text("#${zonaDeportiva.id.toString()}", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12), textAlign: TextAlign.center),*/
                  Text(zonaDeportiva.descripcion, style: TextStyle(fontStyle: FontStyle.italic)),
                  Padding(
                    padding: EdgeInsets.only(left:0, right: 0, top: 20, bottom:20),
                    child: FilaImagenes(zonaDeportiva: zonaDeportiva,),
                  ),
                  Text("Reportes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24), textAlign: TextAlign.left ),
                  FutureBuilder<List<Reporte>>(
                      future: frp,
                      builder: (BuildContext context, AsyncSnapshot<List<Reporte>> snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting)
                          return LinearProgressIndicator(minHeight: 3.0, color: Theme.of(ctx).accentColor,);
                        else if(snapshot.hasError)
                          return Text("Error al consultar reportes.");
                        else if(snapshot.hasData)
                          return Column(
                          children: snapshot.requireData.length==0?
                          [Text("No hay reportes disponibles. Esto no debería pasar.")]:
                          snapshot.requireData.map((e) => ReporteDeporte(reporte:e, zonaDeportiva: zonaDeportiva,)).toList()
                        );
                        else return Text ("Error interno de la App.");
                      },
                )
                ])
            ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation:32,
        );
      }
  );
}