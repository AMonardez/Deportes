import 'package:deportes/models/Reporte.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/screens/ValorarDeporte.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ReporteDeporte extends StatelessWidget {
  final Reporte reporte;
  final ZonaDeportiva zonaDeportiva;
  ReporteDeporte({
    required this.reporte, required this.zonaDeportiva
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> aux = [];
    for(int i=0; i<reporte.atributos.length; i++){
      aux.add(AtributoDeporte(texto: reporte.atributos[i], valoracion: reporte.promedios[i], votos: reporte.votos[i]));
    }

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Reporte.getNombreBonito(reporte.deporte), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left ),
            MaterialButton(
                onPressed: (){valorarDeporte(context, zonaDeportiva, reporte.deporte, reporte.atributos);},
                child: Text("VALORAR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))),
          ],
        ),
        ...aux,
        SizedBox(height: 20),
      ],

    );
  }
}

class AtributoDeporte extends StatelessWidget{
  final String texto;
  final double valoracion;
  final int valormaximo=5;
  final int votos;
  AtributoDeporte({required this.texto,required this.valoracion, required this.votos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(child: Text(texto + "($votos)", overflow: TextOverflow.visible,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.left )),
          RatingStars(
            value: valoracion,
            starBuilder: (index, color) => Icon(
              Icons.star,
              color: color,
            ),
            starCount: valormaximo,
            starSize: 20,
            valueLabelColor: const Color(0xff9b9b9b),
            valueLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 12.0),
            valueLabelRadius: 10,
            maxValue: 5,
            starSpacing: 2,
            maxValueVisibility: true,
            valueLabelVisibility: true,
            animationDuration: Duration(milliseconds: 1000),
            valueLabelPadding:
            const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: const Color(0xffe7e8ea),
            starColor: Colors.yellow,
            onValueChanged: (double val) => null,
          ),
        ]
      ),
    );
  }
}