import 'package:deportes/api/valoraciones_deportes.dart';
import 'package:deportes/models/Reporte.dart';
import 'package:deportes/models/Valoracion.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/Toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

Future<void> valorarDeporte(BuildContext ctx, ZonaDeportiva zd, String deporte, List<String> atributos) async {
  //String deporte= "Fútbol";
  List<double> puntuaciones=List<double>.filled(atributos.length, 3.0);
  int idDeporteEnZona = zd.idDeporteEnZona[zd.deportes.indexOf(deporte)];

  return showDialog<void> (
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog (
              title: Column(
                children: [
                  Text("Valorando ${Reporte.getNombreBonito(deporte)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.left),
                  Text(zd.nombre,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),

              content: Container(
                width: 300,
                height: 80.0*atributos.length,
                child: ListView.builder(
                  shrinkWrap: true,

                  itemCount: atributos.length,
                    itemBuilder: (ctx, i){
                      return new Column(
                        children:[
                          Text(Reporte.getAtributoBonito(atributos[i]), style: TextStyle(fontSize: 16)),
                          RatingStars(
                              value: puntuaciones[i],
                              starBuilder: (index, color) => Icon(Icons.star, color: color, size: 50),
                              starCount: 5,
                              starSize: 55,
                              maxValue: 5,
                              starSpacing: 1,
                              maxValueVisibility: false,
                              valueLabelVisibility: false,
                              animationDuration: Duration(milliseconds: 1000),
                              valueLabelPadding:
                              const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              valueLabelMargin: const EdgeInsets.only(right: 8),
                              starOffColor: const Color(0xffe7e8ea),
                              starColor: Theme.of(context).accentColor,
                              onValueChanged: (double val) => setState(() => puntuaciones[i]=val),
                          ),
                        ]
                      );

                    }),
              ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation:32,
              actionsPadding: EdgeInsets.all(10),
              actions: [
                MaterialButton(
                  child: Text("ENVIAR", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    print("Guardar");
                    Map<String, double> vals={};
                    for(int i =0; i<atributos.length; i++){
                      vals[atributos[i]]=puntuaciones[i];
                    }
                    Valoracion v = Valoracion(atributosEvaluados: vals, deporte: deporte, idDeporteZona: idDeporteEnZona);
                    bool exitoso= await ValoracionesApi.addValoracion(v);
                    if(exitoso){
                      Navigator.pop(context);
                      avisarToast(buildContext: ctx,texto: "Valoración enviada exitosamente.", iconData: Icons.check, color: Theme.of(context).accentColor);
                    }
                    else avisarToast(buildContext: ctx,texto: "Error al enviar valoración.", iconData: Icons.warning, color: Colors.blueGrey);
                  },
                ),
              ]
          );}
        );
      }
  );
}