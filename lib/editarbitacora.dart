import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';

class EditarBitacora extends StatefulWidget {
  String uid;
  String placa;
  String fecha;
  String evento;
  String recursos;
  String verifico;
  String fechaVerificacion;

  EditarBitacora(this.uid,this.placa, this.fecha, this.evento, this.recursos, this.verifico, this.fechaVerificacion);

  @override
  State<EditarBitacora> createState() => _EditarBitacoraState();
}

class _EditarBitacoraState extends State<EditarBitacora> {
  TextEditingController placaController= TextEditingController(text: "");
  TextEditingController fechaController= TextEditingController(text: "");
  TextEditingController eventoController= TextEditingController(text: "");
  TextEditingController recursosController= TextEditingController(text: "");
  TextEditingController verificoController= TextEditingController(text: "");
  TextEditingController fechaVerificacionController= TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    placaController.text = widget.placa;
    fechaController.text = widget.fecha;
    eventoController.text = widget.evento;
    recursosController.text = widget.recursos;
    verificoController.text = widget.verifico;
    fechaVerificacionController.text = widget.fechaVerificacion;

    return Scaffold(
      backgroundColor: Color(0xffFAF2E7),
      appBar: AppBar(
        title: Text("Editar Bitácora"),
        backgroundColor: Color(0xFFC49666),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Text(
              "Actualizar información",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      enabled: false,
                      controller: placaController,
                      decoration: InputDecoration(labelText: 'Placa'),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: fechaController,
                      decoration: InputDecoration(labelText: 'Fecha'),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: eventoController,
                      decoration: InputDecoration(labelText: 'Evento'),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: recursosController,
                      decoration: InputDecoration(labelText: 'Recursos'),
                    ),
                    TextFormField(
                      controller: verificoController,
                      decoration: InputDecoration(labelText: 'Verificó'),
                    ),
                    TextFormField(
                      controller: fechaVerificacionController,
                      decoration: InputDecoration(
                          labelText: 'Fecha de Verificación'),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.brown),
                      ),
                      child: Text('Actualizar'),
                      onPressed: () async {
                        await updateBitacora(
                          widget.uid,
                          verificoController.text,
                          fechaVerificacionController.text,
                        ).then((_) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(
                                  'La operación se ha completado con éxito'),
                              content: Text('Elemento actualizado'),
                            ),
                          );
                          fechaController.text = "";
                          eventoController.text = "";
                          recursosController.text = "";
                          verificoController.text = "";
                          fechaVerificacionController.text = "";
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
