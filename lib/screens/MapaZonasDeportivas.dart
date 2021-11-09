import 'package:deportes/api/zonas_deportivas.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/FiltroDeportes.dart';
import 'package:deportes/widgets/MapaMarcadores.dart';
import 'package:deportes/widgets/MenuAnvorgueso.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapaZonasDeportivas extends StatefulWidget {
  @override
  _MapaZonasDeportivasState createState() => _MapaZonasDeportivasState();

}

class _MapaZonasDeportivasState extends State<MapaZonasDeportivas> {
  Future<List<ZonaDeportiva>> lzd= Future.value([]);

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
        title: Text("Espacios Deportivos en tu Ciudad", style: TextStyle(color: Colors.white)),
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
        child: Stack(
          children: [FutureBuilder<List<ZonaDeportiva>>(
            initialData: [],
            future: lzd,
            builder: (ctx, snapshot){
              if(snapshot.hasData) return MapaMarcadores(snapshot.data!);
              else if(snapshot.hasError) return Text("Error de Future.");
              else if (snapshot.connectionState==ConnectionState.waiting) return CircularProgressIndicator();
              else return Text("Pasas cosaron");
            }
          ),
          Container(
            alignment: Alignment.bottomCenter,
              child: FiltroDeportes())
          ],
        ),
      ),
    );
  }
}

