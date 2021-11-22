import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:deportes/models/ZonaDeportiva.dart';

Future<bool> uploadImagenes(List<Uint8List> imagenes, ZonaDeportiva zd) async{
  print("Endpoint uploadImagenes");
  String servidor = dotenv.env['SERVER_URL']!;
  // http://3.133.104.32:5000/zonasDeportivas/getZonasDeportivas
  var request = http.MultipartRequest('POST', Uri.parse(servidor + '/imagenesZonasDeportivas/upload'));
  request.fields['id_zona_deportiva']=zd.id.toString();
  for(int i=0; i<imagenes.length; i++){
    var imagen = http.MultipartFile.fromBytes('imagenes', imagenes[i], filename: zd.nombre.replaceAll(' ', '_') + i.toString()+'.jpg');
    request.files.add(imagen);
  }
  var response = await request.send();
  print("Response statusCode: " + response.statusCode.toString());
  return response.statusCode==200;
}