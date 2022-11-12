import 'dart:convert';
import 'package:citas_medicas/pages/historialpaciente.dart';
import 'package:citas_medicas/pages/singin.dart';
import 'package:flutter/material.dart'; //Importamos el material.dart  
import 'package:citas_medicas/pages/lostpassword.dart'; 
import 'package:http/http.dart' as http;
import 'dart:async'; 

// Atajo para crear esqueleto: mateapp

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: login() ,
    ),
  );
}
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "Inicia Sesión",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container( //Creamos un contenedor
          child: Center( //centramos el contenido
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                head(),
                headimg(),
                correo(),
                password(),
                passforgot(context),
                btnlogin(context), 
                mensaje(),
                registrate(context),     
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
      )
    );
  }

TextEditingController controllerEmail = new TextEditingController();
TextEditingController controllerPass = new TextEditingController();

String msg = '';
bool _obscureText = true;
bool _status = true;
Future<List> _login() async {
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/login.php'), 
  body: {
    "email": controllerEmail.text,
    "password": controllerPass.text,
  });

  var datauser = json.decode(response.body);

  //print( datauser);

if(datauser.length==0){
   print("Verifica los daros");
   
   setState(() {
      msg="Email o Contraseña Incorrectos";
      _status = false;
    });
   

}else {
  if (datauser[0]['rol'] == 'paciente') { 
    setState(() {
      _status = true; 
      msg="Inició Sesión correctamente";
    });
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>historial()));
    }
}

  return datauser;
}


Widget head() {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0), //Padding con los valores left, top, rigt, button
    //Con child puedes poner un elemento
    child: Text("Inicia Sesión", style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
  );
}
Widget headimg() {
  return Container(
    padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
    child: Image.network("https://umburoff.sirv.com/Images/img_311846.png"), //Imagen de internet
  );
}
Widget correo() { 
  return Container(
    //padding horizontal y vertical
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Column( //contenedor columna para poner varios widgets consecutivos
      children: [ //hace una lista de varios widgeta
        //Campo Correo Electrónico
        TextField(  //Campo de Texto
          controller: controllerEmail,
          decoration: InputDecoration( //Dentro podemos poner los estilos del campo
            prefixIcon: Icon(Icons.email),
            hintText: "Correo Electrónico", //Texto dentro del campo
            fillColor: Colors.white, //color del background del campo
            filled: true, //habilitamos el color
           ),
        ),
    ]),
  );
}

Widget password() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Column(
    children: [
    TextField(
      controller: controllerPass,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: "Contraseña",
        fillColor: Colors.white,
        filled: true,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText=!_obscureText;
            });

          },
          child: Icon(_obscureText 
          ? Icons.visibility 
          : Icons.visibility_off),
        ),   
        ),
      ),
    ]),
  );
}


Widget btnlogin(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () {
        _login();  
        setState(() {
          msg="Intentalo de nuevo";
        });   
      }, //Evento del boton
      child: Text('Iniciar Sesión'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}

Widget mensaje() { 
  return Text(msg,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
}
Widget passforgot(context) {
  return TextButton( //boton sin estilos
    onPressed: () => {

     

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>lostpass()))
      }, //Evento del boton

    child: Text("¿Olvidaste tu Contraseña?"),
    style: TextButton.styleFrom(
      primary: Color.fromARGB(255, 18, 4, 150),
      minimumSize: Size.zero, // Eliminamos el padding del boton
      padding: EdgeInsets.zero, // Eliminamos padding
    ),
  );
}
Widget registrate(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("¿No tienes una cuenta?", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      TextButton(
        onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>singin()))
        }, //Evento del boton
        child: Text("Registrate"),
        style: TextButton.styleFrom(
          primary: Color.fromARGB(255, 18, 4, 150),
          minimumSize: Size.zero, // Set this
          padding: EdgeInsets.zero, // and this
        ),
        ),
    ],
  );
}

}
