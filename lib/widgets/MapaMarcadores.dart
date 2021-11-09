import 'package:deportes/api/zonas_deportivas.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/DetallesZona.dart';

class MapaMarcadores extends StatefulWidget{
  List<ZonaDeportiva> zonas=[];
  @override
  State<StatefulWidget> createState() => MapaMarcadoresState();

  MapaMarcadores(this.zonas);
}

class MapaMarcadoresState extends State<MapaMarcadores>{

  @override
  void initState(){
    super.initState();
  }

  final controller = MapController(
    location: new LatLng(-29.905945639520407, -71.25022183140422),
  );

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
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: GestureDetector(
          onTap: () {
            if(zonaDeportiva!=null){
              print("Marcador tocado");
              detallesZona(context, zonaDeportiva);
            }
            else print("No puede tocarse.");
          },
          child: Icon(icono, size: iconSize, color: color, ),

      ),
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
              LatLng(-29.905945639520407, -71.25022183140422));

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
                      final url = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=pk.eyJ1IjoiYW9raW10IiwiYSI6ImNrdjh5amRlczViZmUydXE5aDI0bHM1NzgifQ.tQyUT2BakFIVJEgx_A_K6w';
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
