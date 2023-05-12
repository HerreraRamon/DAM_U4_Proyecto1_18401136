import 'package:flutter/material.dart';
import 'firebase_services.dart';

class Consulta2 extends StatefulWidget {
  const Consulta2({Key? key}) : super(key: key);

  @override
  _Consulta2State createState() => _Consulta2State();
}

class _Consulta2State extends State<Consulta2> {
  List<String> fechas = [];
  List<Map<String, dynamic>> bitacoras = [];

  Future<void> Consulta2(String fecha) async {
    print(fecha);
    var result = await db.collection('bitacora').where('fecha', isEqualTo: fecha).get();
    if (result.docs.isNotEmpty) {
      setState(() {
        print(fecha);
        bitacoras = result.docs.map((doc) => doc.data()).toList().cast<Map<String, dynamic>>();
      });
    } else {
      setState(() {
        print(fecha);
        bitacoras.clear();
      });
    }
  }

  Future<void> getFechas() async {
    var result = await db.collection('bitacora').orderBy('fecha', descending: true).get();
    setState(() {
      fechas = result.docs.map((doc) => doc.get('fecha')).toSet().toList().cast<String>();
    });
  }

  @override
  void initState() {
    super.initState();
    getFechas();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(
            "Consultar Bitácora por Fecha",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Fecha'),
                  value: null,
                  items: fechas.map((fecha) {
                    return DropdownMenuItem(
                      value: fecha,
                      child: Text(fecha),
                    );
                  }).toList(),
                  onChanged: (fecha) {
                    Consulta2(fecha!);
                  },
                ),
                SizedBox(height: 16.0),
                if (bitacoras.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bitacoras.map((bitacora) {
                      return Column(
                        children: [
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
                      );
                    }).toList(),
                  ),
              ],
            ), //column que contiene los textfield y el button
          ), //container con el formulario
        ], //children del column principal
      ), //column principal
    );
  }
}
