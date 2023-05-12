import 'package:flutter/material.dart';
import 'firebase_services.dart';

class Consulta4 extends StatefulWidget {
  const Consulta4({Key? key}) : super(key: key);

  @override
  _Consulta4State createState() => _Consulta4State();
}

class _Consulta4State extends State<Consulta4> {
  List<Map<String, dynamic>> vehiculos = [];

  Future<void> getVehiculos(String depto) async {
    var result = await db.collection('vehiculo').where('depto', isEqualTo: depto).get();
    setState(() {
      vehiculos = result.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text(
            "Consultar Vehículos por Departamento",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Departamento'),
                  onChanged: (depto) {
                    getVehiculos(depto);
                  },
                ),
                SizedBox(height: 16.0),
                if (vehiculos.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: vehiculos.map((vehiculo) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.directions_car),
                            title: Text('${vehiculo["placa"]}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tipo: ${vehiculo["tipo"]}'),
                                Text('Número de serie: ${vehiculo["numeroserie"]}'),
                                Text('Combustible: ${vehiculo["combustible"]}'),
                                Text('Tanque: ${vehiculo["tanque"]}'),
                                Text('Trabajador: ${vehiculo["trabajador"]}'),
                                Text('Resguardado por: ${vehiculo["resguardadopor"]}'),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
