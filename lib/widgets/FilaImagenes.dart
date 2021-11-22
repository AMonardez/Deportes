import 'dart:async';
import 'dart:typed_data';

import 'package:deportes/api/api_imagenes.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'CuadroImagen.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import 'Toasts.dart';

class FilaImagenes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FilaImagenesState();
  final ZonaDeportiva zonaDeportiva;
  FilaImagenes({required this.zonaDeportiva});
}

class FilaImagenesState extends State<FilaImagenes>{
  StreamController<Widget> overlayController =
  StreamController<Widget>.broadcast();

  @override
  void dispose() {
    overlayController.close();
    super.dispose();
  }

  List<Widget> hacerMiniaturas(){
    List<Widget>aux =[];
    for(int i=0; i<widget.zonaDeportiva.urlimagenes.length; i++){
      aux.add(
          Padding(
            padding: const EdgeInsets.only(right:10),
            child: CuadroImagen(url:widget.zonaDeportiva.urlimagenes[i], onTap: (){
              SwipeImageGallery(
                hideStatusBar: false,
                hideOverlayOnTap: false,
                context: context,
                initialIndex: i,
                itemBuilder: (context, index) {
                  return Image.network(widget.zonaDeportiva.urlimagenes[index]);
                },
                itemCount: widget.zonaDeportiva.urlimagenes.length,
                onSwipe: (index) {
                  overlayController.add(BarraTitulo(
                    title: '${index + 1}/${widget.zonaDeportiva.urlimagenes.length}',
                  ));
                },
                overlayController: overlayController,
                initialOverlay: BarraTitulo(
                  title: '${i+1}/${widget.zonaDeportiva.urlimagenes.length}',
                ),
              ).show();

            }, onDeleteTap: () async {
              bool cosa = await deleteImagen(widget.zonaDeportiva.urlimagenes[i], widget.zonaDeportiva.id);
              if(cosa) avisarToast(buildContext: context, texto: "Imagen eliminada.", iconData: Icons.delete, color: Colors.red[900]!);
              widget.zonaDeportiva.urlimagenes.removeAt(i);
              setState(() {
              });
              //print("hola deletetap");
            },),
          )
      );
    }
    return aux;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...hacerMiniaturas(),
            IconButton(icon: Icon(Icons.add_box), onPressed: () {agregarImagen(context);  },)

          ]
      ),
    );
  }
  void agregarImagen(BuildContext ctx) async {
    List<Uint8List> imagenes =[];
    print(widget.zonaDeportiva.id.toString());
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage(maxHeight: 1000, maxWidth: 1000, imageQuality: 95);
    if(images==null || images.length==0) print("No hay imagenes");
    else {
      for(XFile a in images){
        imagenes.add(await a.readAsBytes());
        setState(() {});
      }
      avisarToast(buildContext: ctx,texto: "Subiendo imágenes...", iconData: Icons.add_to_photos, color: Colors.grey);
      List<String> nuevarutaimagen = await uploadImagenes(imagenes, widget.zonaDeportiva);
      if(nuevarutaimagen.length>0){
        avisarToast(buildContext: ctx,texto: "Imágenes cargadas exitosamente.", iconData: Icons.check, color: Theme.of(context).accentColor);
        setState(() {
          widget.zonaDeportiva.urlimagenes.addAll(nuevarutaimagen);
        });
      }
      else avisarToast(buildContext: ctx,texto: "Ocurrió un error al cargar las imágenes.", iconData: Icons.warning, color: Colors.blueGrey);
    }
  }
}

class BarraTitulo extends StatelessWidget {
  const BarraTitulo({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black.withAlpha(50),
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            tooltip: 'Cerrar',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}