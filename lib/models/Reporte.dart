import 'dart:math';

class Reporte{
  String deporte='';
  List<String> atributos = [];
  List<double> promedios = [];
  List<int> votos = [];
  //Cada elemento de estos arreglos están relacionados cada uno por posición, así que su longitud debe ser la misma!
  //atributos[i] con promedios[i] y votos[i].

  static Map<String, List<String>> _atributosvalorables=
  {
    "futbol": ["Iluminacion", "Arcos", "Cancha"],
    "basquetbol": ["Iluminacion", "Aros", "Cancha"],
    "skate": ["Iluminacion","Pistas", "Rampas", "Obstaculos"],
    "tenis": ["Iluminacion", "Cancha", "Implementos"],
    "calistenia": ["Iluminacion", "Variedad de Maquinas", "Estado Maquinas"
    ],
    "otro": ["Iluminacion", "Estado General"],
  };

  Reporte({required this.deporte, required this.atributos, required this.votos, required this.promedios});

  factory Reporte.fromJson(String deporte, dynamic datos){
    List<String> atrs=[];
    List<double> proms=[];
    List<int> vot=[];
    for(var d in datos){
      atrs.add(d['variable'].toString());
      proms.add(double.tryParse(d['valor'].toString())??9.9);
      vot.add(int.tryParse(d['votos'].toString())??-1);
    }
    return Reporte(deporte: deporte, atributos: atrs, promedios:proms, votos:vot);
  }

  static List<Reporte> reportesDePrueba(List<String> deportes){
    List<Reporte> reportessalidas =[];
    for(String d in deportes){
      List<String> atrAux=[];
      List<double> promAux=[];
      List<int> votAux=[];
      var aux=_atributosvalorables.containsKey(d)?d:"otro";
      for(var a in _atributosvalorables[aux]!){
        atrAux.add(a);
        promAux.add(Random().nextDouble()*5.0);
        votAux.add(Random(33).nextInt(100));
      }
      reportessalidas.add(Reporte(deporte: d, atributos: atrAux, votos: votAux, promedios: promAux));
    }
    return reportessalidas;
  }

  static List<String> getAtributosValorables(String deporte){
    return _atributosvalorables.containsKey(deporte)?
        _atributosvalorables[deporte]!
      : _atributosvalorables['otro']!;
  }

  static getNombreBonito(String clave){
    if(clave=='all') return 'Todos los deportes';
    if(clave=='futbol') return 'Fútbol';
    else if(clave =='basquetbol') return 'Basketball';
    else if(clave =='skate') return 'Skating';
    else if(clave =='calistenia') return 'Calistenia';
    else if(clave == 'tenis') return 'Tenis';
    else return clave[0].toUpperCase() + clave.substring(1).toLowerCase();
  }

}