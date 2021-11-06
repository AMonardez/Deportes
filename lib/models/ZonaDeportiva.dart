class ZonaDeportiva{
  String nombre = '';
  String descripcion = '';
  int id = 0;
  double latitud = 0.0;
  double longitud = 0.0;
  String direccion = "";
  List<String> deportes = [];
  //List<String> deportes = ["Futbol", "Basquetbol", "Calistenia","Tenis", "Skating"]; //USAR ESTOS DEPORTES.

  ZonaDeportiva({required String nombre, String? descripcion, int? id, required double latitud, required double longitud, String? direccion, List<String>? deportes}){
    this.nombre=nombre;
    this.descripcion=descripcion??'';
    this.id=id??-1;
    this.latitud=latitud;
    this.longitud=longitud;
    this.deportes=deportes??[];
    this.direccion= direccion??"";
  }
  @override
  toString(){
    return
    'Nombre: '+ nombre +
    '\nLatitud: ' + latitud.toString() +
    '\nLongitud: ' + longitud.toString() +
    '\nDireccion: ' + direccion.toString() +
    '\nDescripcion: ' + descripcion +
    '\nDeportes: ' + deportes.toString() //No he probado si se serializa una lista de esta forma.
    //El error avisa cuando se serialice para usarla en el endpoint
    //'id': id,
    ;
  }

  factory ZonaDeportiva.fromJson(Map<String, dynamic> json) {
    return ZonaDeportiva(
      nombre: json['nombre'],
      latitud: json['latitud']??0.0,
      longitud: json['longitud']??0.0,
      direccion: json['direccion']??'',
      descripcion: json['descripcion'],
      id: json['id_zona_deportiva'],
      deportes: json['deportes'].cast<String>(),
      // cast() es una función sobre listas que me permite castear sus elementos a otro tipo.
      // deportes viene como List<dynamic> y se necesita como List<String>
    );
  }

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'latitud': latitud,
    'longitud': longitud,
    'direccion': direccion,
    'descripcion': descripcion,
    'deportes': deportes //No he probado si se serializa una lista de esta forma. Debería funcionar.
    //'id': id,
  };

}