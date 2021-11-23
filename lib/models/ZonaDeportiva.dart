import 'dart:convert';

class ZonaDeportiva {
  String nombre = '';
  String descripcion = '';
  int id = 0;
  double latitud = 0.0;
  double longitud = 0.0;
  String direccion = "";
  List<String> deportes = [];
  List<int> idDeporteEnZona = [];
  List<String> colorDeporte = [];
  List<String> urlimagenes = [
    'https://s3-deportes.s3.sa-east-1.amazonaws.com/1637114601806_gato_op.png',
    'https://s3-deportes.s3.sa-east-1.amazonaws.com/1637114544657_ef5f1ddb-1129-4413-96cf-cd3c8cd2ea57_16-9-discover-aspect-ratio_default_1098913.jpg',
    'https://s3-deportes.s3.sa-east-1.amazonaws.com/1637114169271_gato1.jpg',
  ];

  ZonaDeportiva(
      {required String nombre,
      String? descripcion,
      int? id,
      required double latitud,
      required double longitud,
      String? direccion,
      List<String>? deportes,
        List<String>? colorDeporte,
        List<int>? idDeporteEnZona,
        List<String>? urlimagenes,
      }) {
    this.nombre = nombre;
    this.descripcion = descripcion ?? '';
    this.id = id ?? -1;
    this.latitud = latitud;
    this.longitud = longitud;
    this.deportes = deportes ?? [];
    this.direccion = direccion ?? "";
    this.idDeporteEnZona = idDeporteEnZona?? [];
    this.colorDeporte = colorDeporte??[];
    this.urlimagenes = urlimagenes??[];
  }

  @override
  toString() {
    return 'Nombre: ' +
            nombre +
            '\nLatitud: ' +
            latitud.toString() +
            '\nLongitud: ' +
            longitud.toString() +
            '\nDireccion: ' +
            direccion.toString() +
            '\nDescripcion: ' +
            descripcion +
            '\nDeportes: ' +
            deportes
                .toString() //No he probado si se serializa una lista de esta forma.
        //El error avisa cuando se serialice para usarla en el endpoint
        //'id': id,
        ;
  }

  factory ZonaDeportiva.fromJson(Map<String, dynamic> json) {
    return ZonaDeportiva(
      nombre: json['nombre'],
      latitud: double.tryParse(json['latitud'].toString()) ?? 0.0,
      longitud: double.tryParse(json['longitud'].toString()) ?? 0.0,
      direccion: json['direccion'] ?? '',
      descripcion: json['descripcion'],
      id: int.tryParse(json['id_zona_deportiva'].toString())??-1,
      deportes: json['deportes'].cast<String>(),
      idDeporteEnZona: json['id_deportes_en_zona'].cast<int>()??[],
      urlimagenes: json['imagenes'].cast<String>(),
      // cast() es una función sobre listas que me permite castear sus elementos a otro tipo.
      // deportes viene como List<dynamic> y se necesita como List<String>
    );
  }

  Map<String, String> toJson() => {
        'nombre': nombre,
        'latitud': latitud.toString(),
        'longitud': longitud.toString(),
        'direccion': direccion,
        'descripcion': descripcion,
        'deportes': jsonEncode(
            deportes), //No he probado si se serializa una lista de esta forma. Debería funcionar.
        'id': id.toString(),
        "id_deportes_en_zona": idDeporteEnZona.toString()
      };
}