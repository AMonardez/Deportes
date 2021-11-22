import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
class CuadroImagen extends StatelessWidget{
  //String? url='https://picsum.photos/250?image=9';
  final String url;
  final Function onTap;
  CuadroImagen({required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height:70,
            width:70,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Theme.of(context).accentColor, strokeWidth: 2.0,),
          ),
          Center(
            child: Container(
              height:70,
              width:70,
              child: GestureDetector(
                onTap: (){
                  print("Imagen tocada: "+ this.url);
                  onTap();
                },
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: this.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
