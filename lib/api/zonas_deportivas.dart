import 'package:deportes/models/ZonaDeportiva.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiZonasDeportivas{

  static String servidor = 'http://3.133.104.32:5000';
  //TODO: Hacer que la url base se pueda modificar y guardable en el Storage.

  static Future<List<ZonaDeportiva>> getZonasDeportivas() async {
    final response = await http.get(Uri.parse(servidor + '/zonasDeportivas/getZonasDeportivas'));
    print("getZonasDeportivas StatusCode: " + response.statusCode.toString() );
    if(response.statusCode==200){
      List<ZonaDeportiva> aux=[];
      Map<String, dynamic> elementos = jsonDecode(response.body);
      for(var d in elementos["zonas_deportivas"]){
        aux.add(ZonaDeportiva.fromJson(d));
      }
      return aux;
    }
    throw Exception("Error de Api");
    //return [];
  }

  static void addZonaDeportiva(ZonaDeportiva zd){
    //TODO: completar esto
  }

}