import 'package:flutter/material.dart';
import 'firebase_services.dart';

class Consulta1 extends StatefulWidget {
  const Consulta1({Key? key}) : super(key: key);

  @override
  _Consulta1State createState() => _Consulta1State();
}

class _Consulta1State extends State<Consulta1> {
  List<String> placas = [];
  List<dynamic> bitacoras = [];

  Future<void> Consulta1(String placa) async {
    var result = await db.collection('bitacora').where('placa', isEqualTo: placa).get();
    setState(() {
      bitacoras = result.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> getPlacas() async {
    var result = await db.collection('vehiculo').get();
    setState(() {
      placas = result.docs.map((doc) => doc.get('placa')).toList().cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    getPlacas();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(
            "Consultar Vehiculo",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children:[
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Placa'),
                  value: null,
                  items: placas.map((placa) {
                    return DropdownMenuItem(
                      value: placa,
                      child: Text(placa),
                    );
                  }).toList(),
                  onChanged: (placa) {
                    Consulta1(placa!);
                  },
                ),
                SizedBox(height: 16.0),
                if (bitacoras.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var bitacora in bitacoras)
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('Fecha: ${bitacora["fecha"]}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Placa: ${bitacora["placa"]}'),
                              Text('Evento: ${bitacora["evento"]}'),
                              Text('Recursos: ${bitacora["recursos"]}'),
                              Text('Verifico: ${bitacora["verifico"]}'),
                              Text('Fecha de verificación: ${bitacora["fechaverificacion"]}'),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            ), //column que contiene los textfield y el button
          ), //container con el formulario
        ], //children del column principal
      ), //column principal
    );
  }
}
