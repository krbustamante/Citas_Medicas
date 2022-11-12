import 'dart:convert';

import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/historialpaciente.dart'; 
import 'package:flutter/material.dart';  
import 'package:http/http.dart' as http;
import 'dart:async';

class singin extends StatefulWidget {

  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Registrate"),
        ),
        body: Container( //Creamos un contenedor
          
          child: Form( //centramos el contenido
            key: _formkey,
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                Registrate(),
                Nombre(),
                Apellido(),
                Correo_Electronico(),
                Edad(),
                Direccion(),
                Contrasenia(),
                Inicia_Sesion(context),
                btnsingin(context),
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

TextEditingController nombre_txt = new TextEditingController();
TextEditingController apellido_txt = new TextEditingController();
TextEditingController email_txt = new TextEditingController();
TextEditingController edad_txt = new TextEditingController();
TextEditingController direccion_txt = new  TextEditingController();
TextEditingController pass_txt = new TextEditingController();

var _formkey = GlobalKey<FormState>();

void addData() {
  var url = Uri.parse('http://krbustamante.byethost7.com/php/adddata.php');

  http.post(url, body: {
    "name": nombre_txt.text,
    "lastname": apellido_txt.text,
    "email": email_txt.text,
    "direccion": direccion_txt.text,
    "password": pass_txt.text,
    "edad": edad_txt.text,
    "rol": "paciente",
  });
}


Widget Registrate() {
  return Text("Registrate",
    style: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}
Widget Nombre() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextFormField(
      controller: nombre_txt,
      validator: (value){
        if(value.isEmpty) {
          return 'Ingresa tu nombre';
        }
        return null;
      },
      decoration: InputDecoration(
      hintText: "Nombre",
      fillColor: Colors.white,
      filled: true,
      ),
    )
  );
}

Widget Apellido() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: apellido_txt,
      decoration: InputDecoration(
      hintText: "Apellido",
      fillColor: Colors.white,
      filled: true,
      ),
    ),
  );
}

Widget Correo_Electronico() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: email_txt,
      decoration: InputDecoration(
      hintText: "Correo Electronico",
      fillColor: Colors.white,
      filled: true,
      ),
    ),
  );
}

Widget Edad() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: edad_txt,
      decoration: InputDecoration(
      hintText: "Edad",
      fillColor: Colors.white,
      filled: true,
      ),
    ),
  );
}

Widget Direccion() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: direccion_txt,
      decoration: InputDecoration(
      hintText: "Direccion",
      fillColor: Colors.white,
      filled: true,
      ),
    ),
  );
}

Widget Contrasenia() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: pass_txt,
      decoration: InputDecoration(
      hintText: "Contraseña",
      fillColor: Colors.white,
      filled: true,
      ),
    ),
  );
}


Widget Inicia_Sesion(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("¿Ya tienes una cuenta? ", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      TextButton(
        onPressed: () {
          if (_formkey.currentState.validate()) {
            addData();
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>historial()));
          }
          
        }, //Evento del boton
        child: Text("Inicia Sesion"), 
        style: TextButton.styleFrom(
          primary: Color.fromARGB(255, 18, 4, 150),
          minimumSize: Size.zero, // Set this
          padding: EdgeInsets.zero, // and this
        ),
        ),
    ],
  );
}

Widget btnsingin(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>login()))
      }, //Evento del boton
      child: Text('Registrarse'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}
}
