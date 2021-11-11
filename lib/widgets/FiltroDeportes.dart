import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FiltroDeportes extends StatefulWidget {

  final Function(String) onTap;

  const FiltroDeportes({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _FiltroDeportesState createState() => _FiltroDeportesState();

}

class _FiltroDeportesState extends State<FiltroDeportes> {

  static List<IconData> iconos =
  [
    Icons.group_work,
    Icons.sports_soccer,
    Icons.sports_basketball,
    Icons.fitness_center,
    Icons.sports_tennis,
    Icons.skateboarding
  ];
  List<String> listaDeportes = ["all", "futbol", "basquetbol", "calistenia", "tenis", "skate"];
  int activado = 0;
  String getDeporteActivado() => listaDeportes[activado];

  List<Widget> getIconos(){
    List<Widget> aux=[];
    for(int i=0; i<iconos.length; i++){
      aux.add(
          Container(
            decoration: BoxDecoration(
              color: activado==i?Colors.orange:Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(iconos[i]),
              iconSize: 30,
              splashRadius: 24,
              onPressed: () => setState(() {
                activado = i;
                widget.onTap(getDeporteActivado());
              }),
              color: activado==i?Colors.white:Colors.black,
              enableFeedback: true,
              hoverColor: Colors.orangeAccent,
      ),
          ) );
    }
    return aux;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        margin: EdgeInsets.only(bottom: 30, left :20, right:20),
        shape: StadiumBorder(),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getIconos(),
        ),
      ),
    );
  }
}