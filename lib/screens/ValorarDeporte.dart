import 'package:deportes/models/Reporte.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> valorarDeporte(BuildContext ctx, ZonaDeportiva zd, String deporte, Map<String, double> valoraciones) async {
  //String deporte= "Fútbol";
  List<String> atributos=[];
  valoraciones.forEach((key, value) {atributos.add(key);});
  List<double> puntuaciones=List<double>.filled(atributos.length, 0.0);
  
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
                    textAlign: TextAlign.right,
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
                          Text(Reporte.getNombreBonito(atributos[i]), style: TextStyle(fontSize: 16)),
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
                              starColor: Colors.orange,
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
                  child: Text("ENVIAR", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    print("Guardar");
                    //ValoracionesApi.addValoracion(zd.id, atributos, puntuaciones);
                    //TODO: Agregar logica para esto.
                    Navigator.pop(context);
                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Valoración enviada exitosamente.")));
                    //TODO: Buscar una forma de mostrarle al usuario un mensaje que la valoración fue
                    //enviada exitosamente. FlutterToast en web funca raro?,
                    //Snackbar sale detrás de las ventanas modales.
                    //Fluttertoast.showToast(msg: "Enviando Valoración...");

                  },
                ),

              ]

          );}
        );
      }
  );
}