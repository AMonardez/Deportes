class Deporte {
  String nombre;

  Deporte({required this.nombre});

  factory Deporte.fromJson(Map<String, dynamic> json) {
    return Deporte(nombre: json['nombre_tipo_deporte']);
  }
}
