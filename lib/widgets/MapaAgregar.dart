import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapaAgregar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MapaAgregarState();
}

class MapaAgregarState extends State<MapaAgregar> {

  @override
  initState() {
    super.initState();
  }
  double latitud=-29.905945639520407;
  double longitud=-71.25022183140422;
  final controller = MapController(
    location: LatLng(-29.905945639520407, -71.25022183140422),
  );

  void _onDoubleTap() {
    controller.zoom += 0.5;
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

  Widget _buildMarkerWidget(Offset pos, Color color) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 24,
      height: 24,
      child: GestureDetector(
          onTap: (){
            print("Marcador tocado");
          },
        child: Icon(Icons.location_on, size: 40, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapLayoutBuilder(
        controller: controller,
        builder: (context, transformer) {

          final homeLocation =
          transformer.fromLatLngToXYCoords(LatLng(latitud, longitud));

          final homeMarkerWidget =
          _buildMarkerWidget(homeLocation, Colors.orange);

          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onDoubleTap: _onDoubleTap,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onTapUp: (details) {
              final location =
              transformer.fromXYCoordsToLatLng(details.localPosition);

              final clicked = transformer.fromLatLngToXYCoords(location);

              print('${location.longitude}, ${location.latitude}');
              print('${clicked.dx}, ${clicked.dy}');
              print('${details.localPosition.dx}, ${details.localPosition.dy}');
              setState(() {
                latitud=location.latitude;
                longitud=location.longitude;
              });
            },
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
                      //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.

                      //Google Maps
                      /*final url =
                          'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
*/
                      //Mapbox Streets
                       final url =
                           'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/$z/$x/$y?access_token=pk.eyJ1IjoiYW9raW10IiwiYSI6ImNrdjh5amRlczViZmUydXE5aDI0bHM1NzgifQ.tQyUT2BakFIVJEgx_A_K6w';

                      return CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  homeMarkerWidget,


                ],
              ),
            ),
          );
        },
      );
  }
}


