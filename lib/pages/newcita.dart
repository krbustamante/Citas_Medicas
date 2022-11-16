import 'dart:convert';
import 'package:citas_medicas/main.dart'; 
import 'package:flutter/material.dart';  
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart'; 

class singin extends StatefulWidget {
  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {

TextEditingController nombre_txt = new TextEditingController();
TextEditingController apellido_txt = new TextEditingController();
TextEditingController email_txt = new TextEditingController();
TextEditingController edad_txt = new TextEditingController();
TextEditingController direccion_txt = new  TextEditingController();
TextEditingController pass_txt = new TextEditingController();

String msg = '';
String id = '';
final _formkey = GlobalKey<FormState>();
 
Future<List> _newUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/adddata.php'), 
  body: {
    "nombre": nombre_txt.text,
    "apellido": apellido_txt.text,
    "email": email_txt.text,
    "direccion": direccion_txt.text,
    "password": pass_txt.text,
    "edad": edad_txt.text, 
    "rol": "paciente",
  });
  var datauser = json.decode(response.body);
 
  setState(() {
    msg="Cuenta creada!";
    
  });
    
    setState(() {
    msg="Inicia Sesión";
    prefs.setString("email", email_txt.text);
    prefs.setString("password", pass_txt.text);
    prefs.setString("nombre", nombre_txt.text); 
    prefs.setString("apellido", apellido_txt.text);  
    prefs.setString("edad", edad_txt.text);
    prefs.setString("direccion", direccion_txt.text);    
  });

  Navigator.push(context,MaterialPageRoute(builder: (context)=>login()));
  return datauser;
}

Future<List> _verifyEmail() async {
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/getemail.php'), 
  body: {
    "email": email_txt.text,
  });
  var datauser = json.decode(response.body);

if(datauser.length==0){
    
  print("No existe el correo");
  setState(() {
    msg="Creando cuenta...";
  });
  _newUser();
  
}else {
  if (datauser[0]['rol'] == 'paciente') { 
    setState(() {
      msg="Este correo ya existe";
    });
  }
}
  return datauser;
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>login()));
                }, 
              );
            },
          ),       
          centerTitle: true,
          title: Text("Registrate"),
        ),
        body: Container( //Creamos un contenedor
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // ignore: sort_child_properties_last
          child: Form( //centramos el contenido
            key: _formkey,
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro

              ],
            )
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(              
              colors: [
                Colors.cyan.shade200,
                Colors.cyan.shade500,               
              ],  
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,                    
            ),
          ),        
        ) 
      )
    );
  }

Widget mensaje() { 
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0);
  return Text(msg,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
}

}
