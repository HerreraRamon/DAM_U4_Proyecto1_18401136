import 'package:flutter/material.dart';

import 'agregarbitacora.dart';
import 'home.dart';
import 'consultarvehiculos.dart';
import 'agregarvehiculo.dart';
import 'consultarbitacora.dart';
import 'services/consulta1.dart';
import 'services/consulta2.dart';
import 'services/consulta3.dart';
import 'services/consulta4.dart';
 class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}


class _MenuState extends State<Menu> {
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tec de tepic",style:TextStyle(color: Color(0xFFFAF2E7),fontWeight: FontWeight.bold, fontSize: 25),),backgroundColor: Color(
          0xffF58818),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFF2B75B)),
              child: Column(
                children:[
                  CircleAvatar(backgroundColor: Color(0xffD7B5E2),radius: 35,child: Text("Perfil",style: TextStyle(fontSize:15),),),
                  SizedBox(height: 5,),
                  Text("Ramon Herrera", style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: (){showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('¡Hola!'),
                        content: Text('¡Función aun en desarrollo!'),
                      ),
                    );},
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('Editar perfil',style: TextStyle(fontSize: 15),),
                        SizedBox(width: 10,),
                        Icon(Icons.edit),
                      ],),
                  ),

                ],
              ),
            ),
            ElementoMenu("home",0, Icons.home),
            ElementoMenu("Consultar vehiculos",1,Icons.read_more_sharp),
            ElementoMenu("Consultar Bitacoras",2,Icons.search),
            ElementoMenu("Bitacora por placa",3,Icons.search),
            ElementoMenu("Bitacora por fecha",4,Icons.search),
            ElementoMenu("Bitacora por conche en uso",5,Icons.search),
            ElementoMenu("Vehiculo por depto",6,Icons.search),

            SizedBox(height: 50,),
            Divider(),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.phone),
              title: Text('Contactanos',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onTap: () {

              },),
            ListTile(
              hoverColor: Colors.grey,
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              onTap: () {

              },),
          ],
        ),
      ),
      body: Pantallas(),
    );
  }

  Widget Pantallas() {

    switch(_index){

      case 0:{
        return Home();
      }
      case 1:{
        return ConsultarVehiculos();
      }
      case 2:{
        return ConsultarBitacora();
      }
      case 3:{
        return Consulta1();
      }
      case 4:{
        return Consulta2();
      }
      case 5:{
        return Consulta3();
      }
      case 6:{
        return Consulta4();
      }
      default:{
        return ListView();
      }
    }
  }

  Widget ElementoMenu(String s, int i, IconData icono) {
    return InkWell(
      onTap: (){
        setState(() {
          _index=i;
          print(_index);

        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(child: Text(s,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),flex: 3,),
            Icon(icono),
          ],
        ),
      ),
    );
  }

}

