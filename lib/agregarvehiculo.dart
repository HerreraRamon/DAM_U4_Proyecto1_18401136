import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';
import 'package:flutter/material.dart';
class AgregarVehiculo extends StatefulWidget {
  const AgregarVehiculo({Key? key}) : super(key: key);

  @override
  State<AgregarVehiculo> createState() => _AgregarVehiculoState();
}

class _AgregarVehiculoState extends State<AgregarVehiculo> {
  TextEditingController placaController= TextEditingController(text: "");
  TextEditingController tipoController= TextEditingController(text: "");
  TextEditingController numeroserieController= TextEditingController(text: "");
  TextEditingController combustibleController= TextEditingController(text: "");
  TextEditingController tanqueController= TextEditingController(text: "");
  TextEditingController trabajadorController= TextEditingController(text: "");
  TextEditingController deptoController= TextEditingController(text: "");
  TextEditingController resguardadoporController= TextEditingController(text: "");





  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children:[
            Text("Agregar un nuevo vehiculo",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: placaController,
                      decoration: InputDecoration(labelText: 'placa'),
                    ),
                    TextFormField(
                      controller: tipoController,
                      decoration: InputDecoration(labelText: 'tipo'),
                    ),
                    TextFormField(
                      controller: numeroserieController,
                      decoration: InputDecoration(labelText: 'numero de serie'),
                    ),
                    TextFormField(
                      controller: combustibleController,
                      decoration: InputDecoration(labelText: 'Combustible'),
                    ),
                    TextFormField(
                      controller: tanqueController,
                      decoration: InputDecoration(labelText: 'tanque'),

                    ),
                    TextFormField(
                      controller: trabajadorController,
                      decoration: InputDecoration(labelText: 'trabajador'),

                    ),
                    TextFormField(
                      controller: deptoController,
                      decoration: InputDecoration(labelText: 'departamento'),
                    ),
                    TextFormField(
                      controller: resguardadoporController,
                      decoration: InputDecoration(labelText: 'resguardado por'),

                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.brown),),
                      child: Text('Registrar'),
                      onPressed: () async{
                        int tanque=int.parse(tanqueController.text);
                        await addVehiculos(placaController.text, tipoController.text,numeroserieController.text,
                          combustibleController.text,tanque,trabajadorController.text,deptoController.text,resguardadoporController.text).then((_) {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: Text(
                                      'La operacion se a completado con exito'),
                                  content: Text('Elemento guardado'),
                                ),
                          );
                          placaController.text = "";
                          tipoController.text = "";
                          numeroserieController.text= "";
                          combustibleController.text="";
                          tanqueController.text="";
                          trabajadorController.text="";
                          deptoController.text="";
                          resguardadoporController.text="";

                        });

                      },
                    ),
                  ],
                ),//column que contiene los textfield y el button
              ),
            ),//container con el formulario
          ],//children del column principal
        ),//column principal
      ),
    );
  }
}
