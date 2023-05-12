import 'package:dam_u4_proyecto1_18401136/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/editarvehiculo.dart';
import 'agregarvehiculo.dart';


class ConsultarVehiculos extends StatefulWidget {
  const ConsultarVehiculos({Key? key}) : super(key: key);

  @override
  State<ConsultarVehiculos> createState() => _ConsultarVehiculosState();
}

class _ConsultarVehiculosState extends State<ConsultarVehiculos> {
  bool open=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AgregarVehiculo()));
        },
        child: Icon(Icons.add),
      ),
      body:
      ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
          children:[
            Text("Vehiculos Registrados",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),),
            FutureBuilder(
              future: getVehiculos(),
              builder: ((context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(

                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context,index){
                  /////////////////////////////////////////////////////////////////////////////////////////
                        return Itemslista(snapshot.data?[index]['uid'],snapshot.data?[index]['placa'],snapshot.data?[index]['tipo'],
                            snapshot.data?[index]['numeroserie'],snapshot.data?[index]['combustible'],
                            snapshot.data?[index]['tanque'],snapshot.data?[index]['trabajador'],
                            snapshot.data?[index]['depto'],snapshot.data?[index]['resguardadopor']);

                  /////////////////////////////////////////////////////////////////////////////////////////
                      });
                }else{
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

  Widget Itemslista(String uid,String placa, String tipo, String numeroserie,String combustible,int tanque,
      String trabajador, String depto, String resguardadopor) {
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

          title: Text("No. de placa: $placa",style: TextStyle( fontSize: 18),),
          subtitle: Text("Tipo de placa: $tipo",style: TextStyle( fontSize: 16),),
        );
      },
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('numero de serie: $numeroserie',style: TextStyle(fontSize: 18,),),
            Text('combustible: $combustible',style: TextStyle(fontSize: 18,),),
            Text('tanque: $tanque ',style: TextStyle(fontSize: 18,),),
            Text('trabajador: $trabajador ',style: TextStyle(fontSize: 18,),),
            Text('departamento: $depto ',style: TextStyle(fontSize: 18,),),
            Text('resguardado por: $resguardadopor',style: TextStyle(fontSize: 18,),),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Botones(uid,placa, tipo, numeroserie, combustible, tanque, trabajador, depto, resguardadopor),
              ],
            ),

          ],
        ),
      ),
    )
    ]);
  }

  Widget Botones(String uid,String placa, String tipo, String numeroserie,String combustible,int tanque,
      String trabajador, String depto, String resguardadopor) {
    return Row(
      children: [
        ElevatedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditarVehiculo(uid,placa, tipo, numeroserie, combustible, tanque, trabajador, depto, resguardadopor)));
          }, child: Text("editar")),
        SizedBox(width: 10,),
        ElevatedButton(onPressed: (){
          showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  title: Text(
                      '¿esta seguro de querer eliminar la placa: $placa?'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancelar")),
                    TextButton(onPressed: (){
                      deleteVehiculos(uid);
                      Navigator.pop(context);
                    }, child: Text("Eliminar")),
                  ],
                ),
          );
        }, child: Text("eliminar"))
      ],
    );
  }
}
