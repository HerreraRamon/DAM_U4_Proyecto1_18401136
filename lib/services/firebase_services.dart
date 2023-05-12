import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db =FirebaseFirestore.instance;

Future<List> getVehiculos() async{
  List vehiculos=[];
  CollectionReference collectionReferenceVehiculos=db.collection('vehiculo');
  QuerySnapshot queryVehiculos=await collectionReferenceVehiculos.get();
  queryVehiculos.docs.forEach((documento) {
    final Map<String,dynamic> data=documento.data() as Map<String,dynamic>;
    final vehi={
      "uid":documento.id,
      "placa":data["placa"],
      "tipo":data["tipo"],
      "numeroserie":data["numeroserie"],
      "combustible":data["combustible"],
      "tanque":data["tanque"],
      "trabajador":data["trabajador"],
      "depto":data["depto"],
      "resguardadopor":data["resguardadopor"]
    };
    vehiculos.add(vehi);
  });
  return vehiculos;
}

Future<void> addVehiculos(String placa, String tipo, String numeroserie,String combustible,int tanque,
String trabajador, String depto, String resguardadopor) async{
  await db.collection("vehiculo").add({"placa":placa,"tipo":tipo,"numeroserie":numeroserie,
  "combustible":combustible,"tanque":tanque,"trabajador":trabajador,"depto":depto,"resguardadopor":resguardadopor});
}

Future<void> updateVehiculos(String uid,String placa, String tipo, String numeroserie,String combustible,int tanque,
    String trabajador, String depto, String resguardadopor) async{
  await db.collection("vehiculo").doc(uid).set({"placa":placa,"tipo":tipo,"numeroserie":numeroserie,
    "combustible":combustible,"tanque":tanque,"trabajador":trabajador,"depto":depto,"resguardadopor":resguardadopor});
}
Future<void> deleteVehiculos(String uid) async{
  await db.collection("vehiculo").doc(uid).delete();
}


Future<List> getBitacora() async{
  List vehiculos=[];
  CollectionReference collectionReferenceBitacora=db.collection('bitacora');
  QuerySnapshot queryBitacora=await collectionReferenceBitacora.get();
  queryBitacora.docs.forEach((documento) {
    final Map<String,dynamic> data=documento.data() as Map<String,dynamic>;
    final bita={
      "uid":documento.id,
      "placa":data["placa"],
      "fecha":data["fecha"],
      "evento":data["evento"],
      "recursos":data["recursos"],
      "verifico":data["verifico"],
      "fechaverificacion":data["fechaverificacion"]
    };
    vehiculos.add(bita);
  });
  return vehiculos;
}

Future<void> addBitacora(String fecha,String placa, String evento, String recursos, String verifico, String fechaverificacion) async {
  await db.collection("bitacora").add({
    "placa":placa,
    "fecha": fecha,
    "evento": evento,
    "recursos": recursos,
    "verifico": verifico,
    "fechaverificacion": fechaverificacion
  });
}


Future<void> updateBitacora(String uid, String verifico, String fechaverificacion) async {
  await db.collection("bitacora").doc(uid).update({
    "verifico": verifico,
    "fechaverificacion": fechaverificacion,
  });
}

/////////////////// CONSULTAS DE LAS BITACORAS  //////////////////////////////////////////////
Future<List> getBitacoraByPlaca(String placa) async {
  QuerySnapshot querySnapshot = await db.collection('bitacora').where('placa', isEqualTo: placa).get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

Future<List> getBitacoraByFecha(DateTime fecha) async {
  QuerySnapshot querySnapshot = await db
      .collection('bitacora')
      .where('fecha', isEqualTo: fecha)
      .get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

Future<List> getVehiculosEnUso() async {
  QuerySnapshot querySnapshot = await db.collection('vehiculo').where('fechaverificacion', isEqualTo: null).get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}

Future<List> getVehiculosByDepto(String depto) async {
  QuerySnapshot querySnapshot = await db.collection('vehiculo').where('depto', isEqualTo: depto).get();
  return querySnapshot.docs.map((doc) => doc.data()).toList();
}




