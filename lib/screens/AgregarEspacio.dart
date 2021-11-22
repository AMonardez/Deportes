import 'dart:typed_data';

import 'package:deportes/api/zonas_deportivas.dart';
import 'package:deportes/models/ZonaDeportiva.dart';
import 'package:deportes/widgets/MapaAgregar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AgregarEspacio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AgregarEspacioState();
}

class AgregarEspacioState extends State<AgregarEspacio> {
  bool guardando =false;

  final _formKey = GlobalKey<FormState>();
  var nombreController = TextEditingController();
  var descripcionController = TextEditingController();
  double lat = -29.905945639520407;
  double long = -71.25022183140422;
  var deportes = ["futbol", "basquetbol", "calistenia", "tenis", "skate"];
  var deportesSeleccionados = [true, false, false, false, false];
  var deportesIconos = <Widget>[
    Tooltip(child: Icon(Icons.sports_soccer), message: "Futbol"),
    Tooltip(child: Icon(Icons.sports_basketball), message: "Basketball"),
    Tooltip(
        child: Icon(Icons.fitness_center), message: "Calistenia"), //Calistenia?
    Tooltip(child: Icon(Icons.sports_tennis), message: "Tenis"),
    Tooltip(child: Icon(Icons.skateboarding), message: "Skateboard"),
  ];

  List<Uint8List> imagenes =[];

  List<String> getDeportesSeleccionados() {
    List<String> aux = [];
    for (int i = 0; i < deportesSeleccionados.length; i++) {
      if (deportesSeleccionados[i]) aux.add(deportes[i]);
    }
    return aux;
  }

  Future<void> guardar() async {
    if (!_formKey.currentState!.validate() && getDeportesSeleccionados().length==0)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error de datos. Comprueba los campos e intentalo nuevamente.")));
        return ;
      }
    else {
      print("Guardado");
      ZonaDeportiva zd = new ZonaDeportiva(
        latitud: lat,
        longitud: long,
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        deportes: getDeportesSeleccionados(),
      );
      //print(zd.toString());
      setState(() {
        guardando=true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Guardando Zona Deportiva...")));
      bool agregado = await ApiZonasDeportivas.addZonaDeportiva(zd, imagenes);
      if(agregado){
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Zona deportiva agregada exitosamente.")));
      }
      else{
        setState(() {
          guardando=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al guardar.")));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Zona Deportiva"),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                tooltip: "Guardar",
                onPressed: () => guardando?null:guardar())
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                //margin: EdgeInsets.all(25.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Datos de la Zona Deportiva",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: nombreController,
                              scrollPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 1.0),
                              obscureText: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit_rounded),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0)),
                                labelText: 'Nombre',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre de la zona no puede estar vacío.';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: descripcionController,
                              scrollPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 1.0),
                              obscureText: false,
                              minLines: 4,
                              maxLines: 5,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit_rounded),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0)),
                                labelText: 'Descripción del lugar',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'La descripción de la zona no puede estar vacía.';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ToggleButtons(
                              isSelected: deportesSeleccionados,
                              children: deportesIconos,
                              selectedColor: Theme.of(context).accentColor,
                              //fillColor: Color.fromARGB(160, 237, 191, 133),
                              fillColor: Colors.white70,
                              onPressed: (int index) {
                                //Regla: Una zona deportiva no puede no tener deportes.
                                //Esto en realidad evita que exista deportesSeleccionados
                                //completo con false, pero esto debería ser un validador.
                                //Hay que extender ToggleButtons con un mixin para agregarle
                                //un validador pero aun no sabo como hacerlo,
                                //asi que se queda así nomas.
                                int contadorselec= deportesSeleccionados.where((element) => element==true).toList().length;
                                if (!(contadorselec==1 && deportesSeleccionados[index]==true)) {
                                  setState(() {
                                    deportesSeleccionados[index] =
                                        !deportesSeleccionados[index];
                                  });
                                }
                              },
                              constraints: BoxConstraints(
                                  minWidth:
                                      (MediaQuery.of(context).size.width - 46) /
                                          5,
                                  maxHeight: 60,
                                  minHeight: 30),
                              //Funcó con 46 pero fue prueba y error, Se supone que son la suma de los paddings horizontales.
                            )),
                      ],
                    ))),
            Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                //margin: EdgeInsets.all(25.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Ubicación de la Zona Deportiva",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: MapaAgregar(
                                  latitude: lat,
                                  longitude: long,
                                  onMarkerMoved: (lt, lg) {
                                    setState(() {
                                      /*print("LT: $lat");
                                      print("LG: $long");*/
                                      lat = lt;
                                      long = lg;
                                      /*print("Se cambia?");
                                      print("LT: $lat");
                                      print("LG: $long");*/
                                    });
                                  }),
                              height: 400),
                        ),
                      ],
                    ))),
            Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.0)),
                //margin: EdgeInsets.all(25.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Imagenes de la Zona Deportiva",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                [
                                  ...imagenes.map((e) => Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(8.0),
                                        child: Container(height: 150, width: 150, child:Image.memory(e), decoration: BoxDecoration(color: Colors.grey))),
                                    )
                                  ),
                                  SizedBox(height: 100, width: 100,
                                      child: IconButton(icon: Icon(Icons.add_box), onPressed: () =>agregarImagen(),)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ))),
          ]),
        ));
  }

  void agregarImagen() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage(maxHeight: 1000, maxWidth: 1000, imageQuality: 95);
    if(images==null) print("No hay imagenes");
    else {
      for(XFile a in images){
        //imagenes.add(Image.file(File(a.path)));
        imagenes.add(await a.readAsBytes());
      }
    }

    setState(() {});
  }
}
