class Espacio{
  String nombre = '';
  String descripcion = '';
  int id = 0;
  double latitud = 0.0;
  double longitud = 0.0;
  List<String> deportes = [];
  //List<String> deportes = ["Futbol", "Basquetbol", "Calistenia","Tenis", "Skating"]; //USAR ESTOS DEPORTES.

  Espacio({required String nombre, String? descripcion, int? id, double? latitud, double? longitud, List<String>? deportes}){
    this.nombre=nombre;
    this.descripcion=descripcion??'';
    this.id=id??-1;
    this.latitud=latitud??0.0;
    this.longitud=longitud??0.0;
    this.deportes=deportes??[];
  }
}