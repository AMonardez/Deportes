import 'package:deportes/models/ZonaDeportiva.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiZonasDeportivas {
  static String servidor = 'http://3.133.104.32:5000';
  //TODO: Hacer que la url base se pueda modificar y guardable en el Storage.
  // No se si te refieres aca a usar a import 'package:localstorage/localstorage.dart';
  //a partir de la dependencia localstorage: ^4.0.0+1 de alguna version o un archivo de enviroment

  static Future<List<ZonaDeportiva>> getZonasDeportivas() async {
    final response = await http
        .get(Uri.parse(servidor + '/zonasDeportivas/getZonasDeportivas'));
    print("getZonasDeportivas StatusCode: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<ZonaDeportiva> aux = [];
      Map<String, dynamic> elementos = jsonDecode(response.body);
      for (var d in elementos["zonas_deportivas"]) {
        aux.add(ZonaDeportiva.fromJson(d));
      }
      return aux;
    }
    throw Exception("Error de Api");
    //return [];
  }

  /*
  /// ENDPOINTS :
  //static String base_url = 'http://3.133.104.32:5000/';

  // ENDPOINT 1: 
  static Future<List<ZonaDeportiva>> getZonaDeportiva() async {
    final response = await http
        .get(Uri.parse(base_url + 'zonasDeportivas/getZonasDeportivas'));
    if (response.statusCode == 200) {
      List<ZonaDeportiva>? zonas_deportivas;
      Iterable jsonVariable = jsonDecode(response.body)['zonas_deportivas'];
      zonas_deportivas =
          jsonVariable.map((model) => ZonaDeportiva.fromJson(model)).toList();
      return zonas_deportivas;
    } else {
      throw Exception('Error en obtener la lista de zonas deportivas');
    }
  }
  */

  // ENDPOINT 2:
  static Future<bool> addZonaDeportiva(ZonaDeportiva zd) async {
    final response = await http.post(
      Uri.parse(servidor + '/zonasDeportivas'),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: zd.toJson(),
    );
    if (response.statusCode == 200) {
      print("addZonasDeportiva StatusCode: " + response.statusCode.toString());
      return true;
    } else {
      print("addZonasDeportiva StatusCode: " + response.statusCode.toString());
      return false;
      throw Exception('Error al agregar la zona deportiva');

    }
  }
}
