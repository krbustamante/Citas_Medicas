import 'dart:convert';
import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/historialpaciente.dart'; 
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
    prefs.setString("email", email_txt.text);
    prefs.setString("password", pass_txt.text);
    prefs.setString("nombre", nombre_txt.text); 
    prefs.setString("apellido", apellido_txt.text);
  });
    
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>historial()));
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
          title: Text("Registrate"),
        ),
        body: Container( //Creamos un contenedor
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // ignore: sort_child_properties_last
          child: Form( //centramos el contenido
            key: _formkey,
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: const Text("Registrate",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ), 
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: nombre_txt,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu nombre";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: apellido_txt,
                  decoration: InputDecoration(
                    labelText: "Apellido",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu Apellido";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: email_txt,
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) => value!.isEmpty || !value.contains("@")
                  ? "ingresa un correo válido"
                  : null,
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: edad_txt,
                  decoration: InputDecoration(
                    labelText: "Edad",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu edad";
                    } else {
                      return null;
                    }
                  },
                ), 
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: direccion_txt,
                  decoration: InputDecoration(
                    labelText: "Dirección",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu dirección";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: pass_txt,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa una contraseña";
                    } else {
                      return null;
                    }
                  },
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Ya tienes una cuenta? ", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () { 
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>login()));                       
                      },
                    //Evento del boton
                      child: Text("Inicia Sesion"), 
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 18, 4, 150),
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero, // and this
                      ),
                      ),
                  ],
                ),
                mensaje(),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                  child: ElevatedButton( //Boton con estilos ya establecidos
                  onPressed: () {
                    if(_formkey.currentState!.validate()) { 
                      setState(() {
                        msg="Verificando datos...";
                      });                   
                      
                      _verifyEmail();
                    }
                  }, //Evento del boton
                  child: Text('Registrarse'), //Texto del boton
                  style: ElevatedButton.styleFrom( //Definimos estilos
                    backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
                  ),
                  ),
                )
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
