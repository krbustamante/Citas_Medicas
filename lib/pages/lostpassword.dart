import 'dart:convert'; 
import 'package:citas_medicas/pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';  
class lostpass extends StatefulWidget {
  const lostpass({super.key});
  
  @override
  State<lostpass> createState() => _MyAppState();
}
/** Codigo de aplicacion: vpwladplywaasnmt **/
class _MyAppState extends State<lostpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Recupera tu contraseña"),
          ),
          body: Container( //Creamos un contenedor
            child: Center( //centramos el contenido
              child: ListView( //Creamos un contenedor que va poder hacer scroll
                children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                  head(),
                  correo(),
                  mensaje(),
                  btnsendemail(context),
                  SizedBox(height: 20.0,),
                  codigo(),
                  mensajecode(),
                  btnsendcode(),
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
          ),
    );
  }
FocusNode myFocusNode = FocusNode();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
  }
@override
  void dispose() {
    // Limpia el nodo focus cuando se haga dispose al formulario
    myFocusNode.dispose();
        
    super.dispose();
  }
String msg = '';
bool codesended = false;

  Future<List> _verifyEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/getemail.php'), 
  body: {
    "email": email_txt.text,
  });
  var datauser = json.decode(response.body);

if(datauser.length==0){
    
  print("No existe el correo");
  setState(() {
    msg="Este usuario no existe";
  });
  
}else { 
    setState(() {
      msg="Generando codigo...";
      prefs.setBool("logged", false);
      prefs.setString("email", datauser[0]['email']);
      prefs.setString("password", datauser[0]['password']);
      prefs.setString("nombre", datauser[0]['nombre']);
      prefs.setString("ID_Usuario", datauser[0]['ID_Usuario']);
      prefs.setString("apellido", datauser[0]['apellido']);
      prefs.setString("edad", datauser[0]['edad']);
      prefs.setString("direccion", datauser[0]['direccion']);
    }); 

    _sendemail();
}
  return datauser;
}

Future<void> _sendemail() async {
  final response = await http.post(Uri.parse('http://citasmedicas.atwebpages.com/sendemail.php'), 
  body: {
    "email": email_txt.text,
  });
  var datauser = json.decode(response.body);

if(datauser.length==0){
    
  print("Ocurrio un error enviando el correo");
  setState(() {
    msgcode="Ocurrio un error enviando el correo";
  });
  
}else { 
    setState(() {
      msg="Ahora escribe el codigo de verificacion";
      msgcode = "Escribe el codigo de verificacion";
      codigov = datauser.toString();
    }); 
  print("XD parece que funciono" + datauser);

  
  FocusScope.of(context).requestFocus(myFocusNode);
}
}


String codigov = '';
/* Eliminar xd */

TextEditingController codigo_txt = new TextEditingController();

TextEditingController email_txt = new TextEditingController();

Widget head() {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0), //Padding con los valores left, top, rigt, button
    //Con child puedes poner un elemento
    child: Text("Te enviaremos un correo para que puedas restablecer tu contraseña", style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
  );
}
 
Widget correo() {
  return TextFormField(
            controller: email_txt,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: "Correo Electrónico",
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            validator: (value) {
              if(value!.isEmpty) {
                return "Ingresa tu correo";
              } else {
                return null;
              }
            },
          );  
} 
String msgcode = '';
Widget btnsendemail(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      
      onPressed: () => { 
        if (email_txt.text == null || email_txt.text == "") {
          setState(() {
            msg="Escribe tu correo"; 
          })
        } else {
          _verifyEmail(), 
        }
      
      }, //Evento del boton
      child: Text('Enviar'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}


Widget codigo() {
  return TextFormField(
            focusNode: myFocusNode,
            controller: codigo_txt,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.code),
              labelText: "Codigo de Verificacion",
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            validator: (value) {
              if(value!.isEmpty) {
                return "Ingresa tu correo";
              } else {
                return null;
              }
            },
          );  
}  

Future <void> loggedtrue() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setBool("logged", true);
}

 Widget btnsendcode()  {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      
      onPressed: () {
         if (codigo_txt.text == null || codigo_txt.text == "") {
          setState(() {
            msg="Revisa tu email y escribe el codigo de verificacion"; 
          });
        } else {
          if (codigo_txt.text == codigov) {
            loggedtrue();
            setState(() {
              msgcode="Cambia tu contraseña";
            });
            Navigator.push(context,MaterialPageRoute(builder: (context)=>perfil()));
          }
        }
      }, //Evento del boton
      child: Text('Verificar xd'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}


Widget mensaje() { 
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0);
  return Text(msg,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
}
Widget mensajecode() { 
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0);
  return Text(msgcode,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
}



 
}
