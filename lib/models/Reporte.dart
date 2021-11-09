import 'dart:math';

class Reporte{
  Map<String, Map<String, double>> atributos= {
  };

  static Map<String, List<String>> _atributosvalorables=
  {
    "futbol": ["Iluminación", "Arcos", "Cancha"],
    "basquetbol": ["Iluminación", "Aros", "Cancha"],
    "skate": ["Iluminación","Pistas", "Rampas", "Obstaculos"],
    "tenis": ["Iluminación", "Cancha", "Implementos"],
    "calistenia": ["Iluminación", "Variedad de Maquinas",
      /*"Estado Maquinas"*/
    ],
    "otro": ["Iluminación", "Estado General"],
  };

  Reporte.dePrueba(List<String> deportes){
    Map<String, Map<String, double>> salida={};
    for(String d in deportes){
      var aux=_atributosvalorables.containsKey(d)?d:"otro";
      Map<String,double> mapaaux= {};
      for(var a in _atributosvalorables[aux]!){
        mapaaux[a]=Random().nextDouble()*5.0;
      }
      salida[d]=mapaaux;
    }
    atributos=salida;
  }

  static List<String> getAtributosValorables(String deporte){
    return _atributosvalorables.containsKey(deporte)?
        _atributosvalorables[deporte]!
      : _atributosvalorables['otro']!;
  }

  static getNombreBonito(String clave){
    if(clave=='futbol') return 'Fútbol';
    else if(clave =='basquetbol') return 'Basketball';
    else if(clave =='skate') return 'Skating';
    else if(clave =='calistenia') return 'Calistenia';
    else if(clave == 'tenis') return 'Tenis';
    else return clave[0].toUpperCase() + clave.substring(1).toLowerCase();
  }

}