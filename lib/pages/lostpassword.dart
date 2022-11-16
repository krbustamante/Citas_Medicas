import 'dart:convert';

import 'package:citas_medicas/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart'; 

void main() => runApp(const lostpass());

class lostpass extends StatefulWidget {
  const lostpass({super.key});

  @override
  State<lostpass> createState() => _MyAppState();
}

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

String msg = '';
TextEditingController email_txt = new TextEditingController();

  Future<List> _verifyEmail() async {
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
    }); 
    _generateCode();
}
  return datauser;
}


String codigov = '';

Future<List> _generateCode() async {
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/generatecode.php'), 
  body: {
    "email": email_txt.text,
  });
  var codigo = json.decode(response.body);

if(codigo.length==0){
    
  setState(() {
    msg="Ocurrio un error";
  });
} else {
  setState(() {
    msg="Escribe el codigo de verificacion";
    codigov = codigo.toString();
  });
  sendEmail(
    name: "Citas Medicas", 
    email: "kevinricardo258@gmail.com", 
    subject: email_txt.text, 
    message: "Recientemente pediste el restablecimiento de tu constraseña. Ingresa este codigo en la aplicacion y cambia tu contraseña" + codigov,
  );
}
  return codigo;
}

Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  final serviceId = 'service_2xvax86';
  final templateId = 'template_gvjpxva';
  final userId = 'O4fCW71R9ix-XOl0a';

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://krbustamante.byethost7.com/',
      'Content-Type': 'aplication/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': name,
        'user_subject': subject,
        'user_message': message,
      },
    }) 
    );

  print(response.body);
} 
TextEditingController codigo_txt = new TextEditingController();

Widget verifycode() {
  return Form( //centramos el contenido 
    child: ListView( //Creamos un contenedor que va poder hacer scroll
      children: <Widget> [ 
        SizedBox(height: 10.0,),
        Text("Código de verificación: "),
        TextField(
          enabled: false,
          controller: codigo_txt,
          decoration: InputDecoration(
            labelText: "Codigo de Verificación",
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        ElevatedButton( //Boton con estilos ya establecidos
          onPressed: () => {
            if (codigo_txt.text == codigov) {
              setState(() {
                msg="El codigo es correcto!";
              })
            } else {
              setState(() {
                msg="El codigo introducido es incorrecto";
              })
            }
          }, //Evento del boton
          child: Text('Enviar'), //Texto del boton
          style: ElevatedButton.styleFrom( //Definimos estilos
            backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
          ),
        ),
      ]
    )
  );
}

Widget head() {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0), //Padding con los valores left, top, rigt, button
    //Con child puedes poner un elemento
    child: Text("Te enviaremos un correo para que puedas restablecer tu contraseña", style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
  );
}

Widget correo() {
  return Container(
    //padding horizontal y vertical
    padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
    child: Column( //contenedor columna para poner varios widgets consecutivos
      children: [ //hace una lista de varios widgeta
        //Campo Correo Electrónico
        TextField(  //Campo de Texto
          controller: email_txt,
          decoration: InputDecoration( //Dentro podemos poner los estilos del campo
            prefixIcon: Icon(Icons.email),
            hintText: "Correo Electrónico", //Texto dentro del campo
            fillColor: Colors.white, //color del background del campo
            filled: true, //habilitamos el color
           ),
        ),
        Text(msgcode,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,),
        ElevatedButton( //Boton con estilos ya establecidos
          onPressed: () => {
            showDialog(context: context, builder: (context) => AlertDialog(
                title: Text("Recupera tu contraseña"),
                content: Text("Revisa tu correo electrónico y sigue las instrucciones para restablecer tu contraseña."),
                actions: <Widget>[
                  TextButton(
                    child: Text("Aceptar"),
                    onPressed: () => {

                      _verifyEmail(),

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>login()))
                    },
                  ),
                ],
              )
            )
          }, //Evento del boton
          child: Text('Enviar'), //Texto del boton
          style: ElevatedButton.styleFrom( //Definimos estilos
            backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
          ),
        ),
    ]),
  );
} 
String msgcode = '';
Widget btnsendemail(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () => {
        showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Recupera tu contraseña"),
            content: Text("Revisa tu correo electrónico y sigue las instrucciones para restablecer tu contraseña."),
            actions: <Widget>[
              TextButton(
                child: Text("Aceptar"),
                onPressed: () => {

                  _verifyEmail(),

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>login()))
                },
              ),
            ],
          )
        )
      }, //Evento del boton
      child: Text('Enviar'), //Texto del boton
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
}
