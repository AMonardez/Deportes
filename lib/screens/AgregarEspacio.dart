import 'package:deportes/widgets/MapaAgregar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AgregarEspacio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AgregarEspacioState();
}

class AgregarEspacioState extends State<AgregarEspacio> {
  final _formKey = GlobalKey<FormState>();
  var nombreController = TextEditingController();
  var descripcionController = TextEditingController();
  double lat = 0.0;
  double long = 0.0;
  var deportes = ["Futbol", "Basquetbol", "Calistenia","Tenis", "Skating"];
  var deportesSeleccionados = [false, false, false, false, false];
  var deportesIconos = <Widget>[
    Tooltip(child:Icon(Icons.sports_soccer),message: "Futbol"),
    Tooltip(child:Icon(Icons.sports_basketball), message: "Basketball"),
    Tooltip(child:Icon(Icons.fitness_center), message: "Calistenia"),//Calistenia?
    Tooltip(child:Icon(Icons.sports_tennis), message: "Tenis"),
    Tooltip(child:Icon(Icons.skateboarding), message: "Skateboard"),
  ];

  void guardar(){
    print("Guardado");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agregar Espacio Deportivo"),
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white70,
          actions: <Widget>[IconButton(icon: Icon(Icons.save),
              tooltip: "Guardar",
              onPressed: () => guardar() )],

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
                              child: Text("Datos del Espacio Deportivo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: nombreController,
                              scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                              obscureText: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit_rounded),

                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0)),
                                labelText: 'Nombre',
                              ),
                              validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'El nombre del espacio no puede estar vacío.';
                                }
                                return null;
                              }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              controller: descripcionController,
                              scrollPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
                              obscureText: false,
                              minLines: 4,
                              maxLines:5,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.edit_rounded),

                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0)),
                                labelText: 'Descripción del lugar',
                              ),
                              /*validator: (String? value){
                                if (value == null || value.isEmpty) {
                                  return 'El nombre del espacio no puede estar vacío.';
                                }
                                return null;
                              }*/
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ToggleButtons(
                            isSelected: deportesSeleccionados,
                            children: deportesIconos,
                            selectedColor: Colors.orange,
                            //fillColor: Color.fromARGB(160, 237, 191, 133),
                            fillColor: Colors.white70,
                            onPressed: (int index) {
                              setState(() {
                                deportesSeleccionados[index]= !deportesSeleccionados[index];
                              });
                            },
                            constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 46) / 5, maxHeight: 60, minHeight: 30),
                            //Funcó con 46 pero fue prueba y error, Se supone que son la suma de los paddings horizontales.

                          )
                        ),

                      ],
                    )
                )),
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
                              child: Text("Ubicación del Espacio Deportivo",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: MapaAgregar(), height:400),

                        ),

                      ],
                    )
                )),

          ]),
        ));
  }
}
