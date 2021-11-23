import 'package:deportes/api/zonas_deportivas.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/FiltroDeportes.dart';
import 'package:deportes/widgets/MapaMarcadores.dart';
import 'package:deportes/widgets/MenuAnvorgueso.dart';
import 'package:deportes/widgets/Toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapaZonasDeportivas extends StatefulWidget {
  @override
  _MapaZonasDeportivasState createState() => _MapaZonasDeportivasState();
}

class _MapaZonasDeportivasState extends State<MapaZonasDeportivas> {
  Future<List<ZonaDeportiva>> lzd= Future.value([]);
  String deporteSeleccionado='all';

  List<ZonaDeportiva> filtrar(List<ZonaDeportiva>l, String deporte){
    if(deporte=='all') return l;
    List<ZonaDeportiva> aux=[];
    for(var z in l) if(z.deportes.contains(deporte)) aux.add(z);
    return aux;
  }

  @override
  void initState() {
    super.initState();
    lzd= ApiZonasDeportivas.getZonasDeportivas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Flexible(child: Text("Zonas Deportivas en tu Ciudad", style: TextStyle(color: Colors.white))),
          ],
        ),
        backgroundColor: Colors.black26,
        foregroundColor: Colors.white,
        elevation: 0.0,

        actions:[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: () {
            setState(() {
              //lzd=Future.value([]);
              lzd= ApiZonasDeportivas.getZonasDeportivas();
            });
            }),
        ],

      ),
      drawer: MenuAnvorgueso(),


      body: Center(
        child: FutureBuilder<List<ZonaDeportiva>>(
          initialData: [],
          future: lzd,
          builder: (ctx, snapshot){
            if(snapshot.hasData) return
              Stack(children: [
                MapaMarcadores(filtrar(snapshot.data!, deporteSeleccionado)),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FiltroDeportes(
                    onTap: (dep) {setState(() {
                      deporteSeleccionado=dep;
                    }); },
                  )
                )
              ]
            );

            else if(snapshot.hasError) {
                avisarToast(buildContext: ctx, texto: snapshot.error.toString(), iconData: Icons.warning, color: Colors.red[600]!);
                return Text("Error de conexión. \n Inténtalo más tarde.");
            } else if (snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
            else return Text("Pasas cosaron");
          }
        ),
      ),
    );
  }
}

