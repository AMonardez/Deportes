import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:deportes/models/ZonaDeportiva.dart';

Future<List<String>> uploadImagenes(List<Uint8List> imagenes, ZonaDeportiva zd) async{
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
  //TODO: Leer y retornar las urls de las imagenes subidas.
  //Lo de la imagen de donfrancisco es provisorio.
  String imagendonfrancisco='https://s3-deportes.s3.sa-east-1.amazonaws.com/1637545124552_Plaza_de_la_Juventud0.jpg';
  if(response.statusCode==200) return [imagendonfrancisco];
  else return [];
}

Future<bool> deleteImagen(String url, int idZonaDeportiva) async {
  String servidor = dotenv.env['SERVER_URL']!;
  String endpoint = "/imagenesZonasDeportivas/delete";
  print("Endpoint deleteImagen");
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  var request = http.Request('POST', Uri.parse(servidor + endpoint));
  request.bodyFields = {
    'id_zona_deportiva': idZonaDeportiva.toString(),
    'rutas_imagenes': '["$url"]'
  };
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  print("ResponseStatusCode " + response.statusCode.toString());
  //print(response.headers.toString());
  var body = jsonDecode(await response.stream.bytesToString());
  //print("body: "+body.toString());
  bool ret = body['ok']??false;
  print("Return: "+ ret.toString());
  return ret;
}