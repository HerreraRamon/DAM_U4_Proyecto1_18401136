import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';
class EditarVehiculo extends StatefulWidget {

  String uid;
  String placa;
  String tipo;
  String numeroserie;
  String combustible;
  int tanque;
  String trabajador;
  String depto;
  String resguardadopor;
  EditarVehiculo(this.uid,this.placa, this.tipo, this.numeroserie, this.combustible, this.tanque, this.trabajador, this.depto, this.resguardadopor);

  @override
  State<EditarVehiculo> createState() => _EditarVehiculoState();
}

class _EditarVehiculoState extends State<EditarVehiculo> {

  TextEditingController placaController= TextEditingController(text: "");
  TextEditingController tipoController= TextEditingController(text: "");
  TextEditingController numeroserieController= TextEditingController(text: "");
  TextEditingController combustibleController= TextEditingController(text: "");
  TextEditingController tanqueController= TextEditingController(text: "");
  TextEditingController trabajadorController= TextEditingController(text: "");
  TextEditingController deptoController= TextEditingController(text: "");
  TextEditingController resguardadoporController= TextEditingController(text: "");
  final _formKe = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    placaController.text = widget.placa;
    tipoController.text = widget.tipo;
    numeroserieController.text = widget.numeroserie;
    combustibleController.text = widget.combustible;
    tanqueController.text = widget.tanque.toString();
    trabajadorController.text = widget.trabajador;
    deptoController.text = widget.depto;
    resguardadoporController.text = widget.resguardadopor;
    return Scaffold(
        backgroundColor: Color(0xffFAF2E7),
    appBar: AppBar(
    title: const Text("Tec de tepic",style:TextStyle(color: Color(0xFFFAF2E7),fontWeight: FontWeight.bold, fontSize: 25),),backgroundColor: Color(
    0xFFC49666),
    ),
    body:SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children:[
          Text("Actualizar información",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKe,
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
                    child: Text('Actualizar'),
                    onPressed: () async{
                      int tanque=int.parse(tanqueController.text);
                      await updateVehiculos(widget.uid,placaController.text, tipoController.text,numeroserieController.text,
                          combustibleController.text,tanque,trabajadorController.text,deptoController.text,resguardadoporController.text).then((_) {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Text(
                                    'La operación se a completado con exito'),
                                content: Text('Elemento actualizado'),
                              ),
                        );


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
