import 'dart:async';

import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:location/location.dart';

import '../screens/DetallesZona.dart';

class MapaMarcadores extends StatefulWidget{
  final List<ZonaDeportiva> zonas;
  @override
  State<StatefulWidget> createState() => MapaMarcadoresState();
  MapaMarcadores(this.zonas);
}

class MapaMarcadoresState extends State<MapaMarcadores>{
  //Locator
  bool primeraUbicacion=true;

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  Future<List<double>> getLiveLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return([latDefault, longDefault]);
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return([latDefault, longDefault]);
      }
    }
    _locationData = await location.getLocation();
    print("${_locationData.latitude} , ${_locationData.longitude}");
    //controller.center= LatLng(_locationData.latitude??longDefault, _locationData.longitude??latDefault);
    return([_locationData.latitude??longDefault, _locationData.longitude??latDefault]);
  }

  //Locator

  @override
  initState() {
    super.initState();
    print("initstate");
    ubicacion= new LatLng(latDefault, longDefault);
    latHome = latDefault;
    longHome = longDefault;
    controller = MapController(
      location: new LatLng(latDefault, longDefault),
    );
    getLiveLocation().then((value) {
      print("auxLoc??");
      setState(() {
        latHome = value[0];
        longHome= value[1];
        controller.center= LatLng(latHome, longHome);
        ubicacion = new LatLng(latHome, longHome);
      });
    });
    escuchador= location.onLocationChanged.listen((LocationData currentLocation) {
      print("Listener");
      setState(() {
        updateLocation(currentLocation.latitude??latDefault, currentLocation.longitude??longDefault);
      });


    });
  }
  late StreamSubscription escuchador;

  void updateLocation (double auxLat, double auxLong){
    print("updateLocation");
    setState(() {
      if(primeraUbicacion){
        setState(() {
          primeraUbicacion=false;
          controller.center = LatLng(auxLat, auxLong);
        });
      }
      longHome=auxLong;
      latHome = auxLat;
    });
  }


  @override
  void dispose() {
    escuchador.cancel();
    super.dispose();
  }

  final double latDefault= -29.905945639520407;
  final double longDefault= -71.25022183140422;
  late double latHome, longHome;

  var ubicacion;
  late MapController controller;

  void _onDoubleTap() {
    controller.zoom += 1.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }
  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget({required Offset pos, ZonaDeportiva? zonaDeportiva,
      required Color color, double iconSize=40,
      IconData? icono=Icons.location_on}) {
    return Positioned(
      left: pos.dx-iconSize*0.75, //"funciona", pero no sé por qué.
      top: pos.dy-iconSize,
      //Puede que iconSize no sea de la misma dimensión que pos.dx y pos.dy??? 🤔🤔🤔🤔🤔🤔
      width: iconSize,
      height: iconSize,
      //Los hitboxes de los iconbutton quedan algo desplazados,
      //pero funciona por ahora.
      child: IconButton(iconSize: iconSize,
          onPressed: () {
        if(zonaDeportiva!=null){
          print("Marcador tocado");
          detallesZona(context, zonaDeportiva);
        }
        else print("No puede tocarse.");
      }, icon: Icon(icono, size: iconSize, color: color, ))

    );
  }

  @override
  Widget build(BuildContext context) {

    return MapLayoutBuilder(
            controller: controller,
            builder: (context, transformer) {
              final List<Widget> markerWidgets=
              widget.zonas.map( (z) {
                return _buildMarkerWidget(
                    pos: transformer.fromLatLngToXYCoords(LatLng(z.latitud, z.longitud)),
                    color: Colors.orange,
                    zonaDeportiva: z,
                  ) ;
              }).toList();
              final homeLocation =
              transformer.fromLatLngToXYCoords(
                  LatLng(latHome, longHome));

              final homeMarkerWidget =
              _buildMarkerWidget(
                  pos:homeLocation,
                  color: Colors.blue,
                  zonaDeportiva: null,
                  icono: Icons.album, iconSize: 20);

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _onDoubleTap,
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                onTapUp: (details) {},
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta;
                      controller.zoom -= delta.dy / 1000.0;
                      setState(() {});
                    }
                  },
                  child: Stack(
                    children: [
                      Map(
                        controller: controller,
                        builder: (context, x, y, z) {
                          final url = "https://api.mapbox.com/styles/v1/aokimt/ckvveny7o0wlo14mqlikayhhp/tiles/256/$z/$x/$y@2x?access_token=pk.eyJ1IjoiYW9raW10IiwiYSI6ImNrdjh5amRlczViZmUydXE5aDI0bHM1NzgifQ.tQyUT2BakFIVJEgx_A_K6w";
                          //final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=pk.eyJ1IjoiYW9raW10IiwiYSI6ImNrdjh5amRlczViZmUydXE5aDI0bHM1NzgifQ.tQyUT2BakFIVJEgx_A_K6w';
                          return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
                        },
                      ),
                      homeMarkerWidget,
                      ...markerWidgets,
                    ],
                  ),
                ),
              );
            },
        );
  }
}
