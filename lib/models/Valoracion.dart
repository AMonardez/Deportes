import 'dart:convert';

class Valoracion{
  int idDeporteZona;
  String deporte;
  Map<String, double> atributosEvaluados;
  int idUsuario = 120;

  Valoracion({required this.idDeporteZona,required this.deporte, required this.atributosEvaluados});

  List<String> getAtributosValorables() => atributosEvaluados.entries.map((e) => e.key).toList();

  Map<String, String> toJson()=>{
    'id_deporte_en_zona': idDeporteZona.toString(),
    'nombre_tipo_deporte': deporte.toString(),
    'valorizaciones': jsonEncode(atributosEvaluados.entries.map((e) => {"variable": e.key, "puntuacion": e.value}).toList()),
    'id_usuario': idUsuario.toString(),
  };

  @override
  toString() {
    return toJson().toString();
  }
}