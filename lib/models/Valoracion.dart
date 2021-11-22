class Valoracion{
  int idDeporteZona;
  String deporte;
  Map<String, double> atributosEvaluados;
  int idUsuario = 120;

  Valoracion({required this.idDeporteZona,required this.deporte, required this.atributosEvaluados});

  List<String> getAtributosValorables() => atributosEvaluados.entries.map((e) => e.key).toList();

  Map<String, dynamic> toJson()=>{
    'id_deporte_en_zona': idDeporteZona.toString(),
    'nombre_tipo_deporte': deporte.toString(),
    'valorizaciones': atributosEvaluados.entries.map((e) => {"variable": e.key.toLowerCase(), "puntuacion": e.value}).toList(), //uffff
    'id_usuario': idUsuario.toString(),
  };

  @override
  toString() {
    return toJson().toString();
  }

  //double getPuntuacion(String deporteBuscado) => atributosEvaluados.containsKey(deporteBuscado)?atributosEvaluados[deporteBuscado]:-1.0 ;

}