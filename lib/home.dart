import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 30),
          children: [
            //BANNER DE DONACIÓN
            //MENSAJE DE BIENVENIDA CON DESCRIPCIÓN DE UTILIDADES DE LA APLICACIÓN
            Image.asset("assets/img.png",width: 150,height: 150, opacity: const AlwaysStoppedAnimation(.5),),
            Text("¡¡Bienvenido!!",
              style: TextStyle(color: Colors.orange, fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            Container(
              padding: EdgeInsets.all(30),
              child:
              Text("Esta plataforma tiene la función de organizar y administrar los vehiculos del tec de tepic",
                style: TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.justify,),

            ),
            Divider(),

          ],
        );
  }
}
