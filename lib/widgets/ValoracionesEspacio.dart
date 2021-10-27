import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ValoracionEspacio extends StatelessWidget{
  String texto="";
  double valoracion=0.0;
  int valormaximo=5;
  ValoracionEspacio({required String texto,required double valor}){
    this.texto=texto;
    this.valoracion=valor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(texto, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.left ),
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
        ),
      ]
    );

  }

}