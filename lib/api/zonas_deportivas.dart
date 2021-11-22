import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class ApiZonasDeportivas {
  static String servidor = dotenv.env['SERVER_URL']!;

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
          jsovar ble.map((model) => ZonaDeportiva.fromJson(model)).toList();
      return zonas_deportivas;
    } else {
      throw Exception('Error en obtener la lista de zonas deportivas');
    }
  }
  */

  // ENDPOINT 2:
  static Future<bool> addZonaDeportiva(ZonaDeportiva zd, List<Uint8List> imagenes) async {
    var request = http.MultipartRequest('POST', Uri.parse(servidor + '/zonasDeportivas'));
    request.fields.addAll(zd.toJson());
    for(int i=0; i<imagenes.length; i++){
      var imagen = http.MultipartFile.fromBytes('imagenes', imagenes[i],
          filename: zd.nombre.replaceAll(' ', '_') +'_'+ i.toString()+'.jpg');
      request.files.add(imagen);
    }
    var response = await request.send();
    return response.statusCode==200;
  }
}
