import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'editarbitacora.dart';
import 'agregarbitacora.dart';


class ConsultarBitacora extends StatefulWidget {
  const ConsultarBitacora({Key? key}) : super(key: key);

  @override
  State<ConsultarBitacora> createState() => _ConsultarBitacoraState();
}

class _ConsultarBitacoraState extends State<ConsultarBitacora> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AgregarBitacora()));
        },
        child: Icon(Icons.add),
      ),
      body:
      ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        children: [
          Text("Bitácora de eventos", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),),
          FutureBuilder(
            future: getBitacora(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      /////////////////////////////////////////////////////////////////////////////////////////
                      return Itemslista(snapshot.data?[index]['uid'],
                          snapshot.data?[index]['placa'],
                          snapshot.data?[index]['fecha'],
                          snapshot.data?[index]['evento'],
                          snapshot.data?[index]['recursos'],
                          snapshot.data?[index]['verifico'],
                          snapshot.data?[index]['fechaverificacion']);
                      /////////////////////////////////////////////////////////////////////////////////////////
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            ),),
        ],
      ),
    );
  }

  Widget Itemslista(String uid,String placa, String fecha, String evento, String recursos,
      String verifico, String fecha_verificacion) {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            open = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            isExpanded: open,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text("Placa: $placa", style: TextStyle(fontSize: 18),),
                subtitle: Text(
                  "Fecha: $fecha", style: TextStyle(fontSize: 16),),
              );
            },
            body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Evento: $evento", style: TextStyle(fontSize: 18),),
                  Text('Recursos: $recursos', style: TextStyle(fontSize: 18,),),
                  Text('Verificado por: $verifico',
                    style: TextStyle(fontSize: 18,),),
                  Text('Fecha de verificación: $fecha_verificacion ',
                    style: TextStyle(fontSize: 18,),),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Botones(uid,placa, fecha, evento, recursos, verifico,
                          fecha_verificacion),
                    ],
                  )
                ],
              ),
            ),
          )
        ]);
  }

  Widget Botones(String uid,String placa, String fecha, String evento, String recursos,
      String verifico, String fecha_verificacion) {
    return Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    EditarBitacora(uid,placa, fecha, evento, recursos, verifico,
                        fecha_verificacion)));
              }, child: Text("editar"))
        ]);
  }
}
