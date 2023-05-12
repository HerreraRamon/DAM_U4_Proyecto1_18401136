import 'package:flutter/material.dart';
import 'firebase_services.dart';

class Consulta3 extends StatefulWidget {
  const Consulta3({Key? key}) : super(key: key);

  @override
  _Consulta3State createState() => _Consulta3State();
}

class _Consulta3State extends State<Consulta3> {
  List<Map<String, dynamic>> vehiculos = [];

  Future<void> getVehiculos() async {

    var bitacoraDocs = await db.collection('bitacora').where('fechaverificacion', isEqualTo: '').get();
    var vehiculosResult = [];

    for (var bitacoraDoc in bitacoraDocs.docs) {
      var vehiculoDoc = await db.collection('vehiculos').doc(bitacoraDoc['placa']).get();
      vehiculosResult.add(vehiculoDoc.data()!);
    }

    setState(() {
      vehiculos = vehiculosResult.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    super.initState();
    getVehiculos();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(
            "Consulta de vehículos en uso o fuera de la institución",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          if (vehiculos.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: vehiculos.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text('Placa: ${vehiculos[index]["placa"]}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${vehiculos[index]["tipo"]}'),
                            Text('Número de serie: ${vehiculos[index]["numeroserie"]}'),
                            Text('Combustible: ${vehiculos[index]["combustible"]}'),
                            Text('Tanque: ${vehiculos[index]["tanque"]}'),
                            Text('Trabajador: ${vehiculos[index]["trabajador"]}'),
                            Text('Resguardado por: ${vehiculos[index]["resguardadopor"]}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          if (vehiculos.isEmpty)
            Text(
              "No hay vehículos en uso o fuera de la institución",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
