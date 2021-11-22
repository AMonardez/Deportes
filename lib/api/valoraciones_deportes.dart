import 'dart:convert';

import 'package:deportes/models/Reporte.dart';
import 'package:deportes/models/Valoracion.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ValoracionesApi{
  static String servidor = dotenv.env['SERVER_URL']!;

  static Future<bool> addValoracion(Valoracion v) async{
    //TODO: Arreglar esto.
    print("Llamada addValoracion");
    String endpoint= "/valorizaciones";
    var response = await http.post(Uri.parse(servidor + endpoint),
        body: jsonEncode(v));
    print("jsonEncode: "+ jsonEncode(v));
    print("addValoracion: "+ response.statusCode.toString());
    print("Response:" + response.body);
    return response.statusCode==200;
  }

  static Future<List<Reporte>> getReportes(ZonaDeportiva zd) async {
    print("Llamada getReportes");
    List<Reporte> aux =[];
    String endpoint = '/valorizaciones/getReportes';
    var response = await http.post(Uri.parse(servidor + endpoint),
        body: {"id_zona_deportiva" : zd.id.toString()}
    );
    print('getReportes: '+ response.statusCode.toString());
    if (response.statusCode==200){
      Map<String, dynamic> elementos = jsonDecode(response.body);
      for(var d in elementos['deportes']){
        aux.add(Reporte.fromJson(d['deporte'].toString(), d['reporte']));
      }
      //return Reporte.reportesDePrueba(zd.deportes);
      return aux;
    }
    else throw Exception("Error de api: getReportes");
  }

}