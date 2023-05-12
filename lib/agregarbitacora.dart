import 'dart:ffi';

import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';
import 'package:flutter/material.dart';


class AgregarBitacora extends StatefulWidget {
  const AgregarBitacora({Key? key}) : super(key: key);

  @override
  State<AgregarBitacora> createState() => _AgregarBitacoraState();
}

class _AgregarBitacoraState extends State<AgregarBitacora> {

  TextEditingController placaController= TextEditingController(text: "");
  TextEditingController fechaController = TextEditingController();
  TextEditingController eventoController= TextEditingController(text: "");
  TextEditingController recursosController= TextEditingController(text: "");
  TextEditingController verificoController= TextEditingController(text: "");
  TextEditingController fechaVerificacionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  _showDatePicker() async{
    final DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2020), lastDate: DateTime(2025));
    if ( date!= null) {
      setState(() {
        fechaController.text = date.toString(); // o date.toLocal().toString() si quieres la hora local
      });
    }
  }
  _showDatePicker2() async{
    final DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2020), lastDate: DateTime(2025));
    if ( date!= null) {
      setState(() {
        fechaVerificacionController.text = date.toString(); // o date.toLocal().toString() si quieres la hora local
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Text(
              "Agregar nueva bitácora",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: _showDatePicker,
                      child: Text("Tomar fecha de la bitacora",textAlign: TextAlign.left,),
                      color: Colors.blue,
                    ),
                    TextFormField(
                      controller: placaController,
                      decoration: InputDecoration(labelText: 'Placa'),
                    ),
                    TextFormField(
                      controller: eventoController,
                      decoration: InputDecoration(labelText: 'Evento'),
                    ),
                    TextFormField(
                      controller: recursosController,
                      decoration: InputDecoration(labelText: 'Recursos'),
                    ),
                    TextFormField(
                      controller: verificoController,
                      decoration: InputDecoration(labelText: 'Verificó'),
                    ),
                    MaterialButton(
                      onPressed: _showDatePicker2,
                      child: Text("Fecha de verificación",textAlign: TextAlign.left,),
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      child: Text('Registrar'),
                      onPressed: () async {
                        await addBitacora(
                          fechaController.text,
                          placaController.text,
                          eventoController.text,
                          recursosController.text,
                          verificoController.text,
                          fechaVerificacionController.text,
                        ).then((_) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('La operación se ha completado con éxito'),
                              content: Text('Elemento guardado'),
                            ),
                          );
                          fechaController.text = "";
                          placaController.text="";
                          eventoController.text = "";
                          recursosController.text = "";
                          verificoController.text = "";
                          fechaVerificacionController.text = "";
                        });
                      },
                    ),
                  ],
                ), //column que contiene los textfield y el button
              ),
            ), //container con el formulario
          ], //children del column principal
        ), //column principal
      ),
    );
  }


}
