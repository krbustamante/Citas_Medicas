import 'package:citas_medicas/pages/lostpassword.dart';
import 'package:flutter/material.dart';

class singin extends StatefulWidget {

  @override
  State<singin> createState() => _singinState();
}

class _singinState extends State<singin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrate"),
      ),
      body: Container( //Creamos un contenedor
          child: Center( //centramos el contenido
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                Registrate(),
                Nombre(),
                Apellido(),
                Correo_Electronico(),
                Edad(),
                Direccion(),
                Contrasenia(),
                Inicia_Sesion(context)
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
    );
  }
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
    child: TextField(
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
    child: TextField(
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
    child: TextField(
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
    child: TextField(
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
    child: TextField(
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
    child: TextField(
      decoration: InputDecoration(
      hintText: "Contraseña",
      filled: true,
      ),
    ),
  );
}


Widget Inicia_Sesion(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("¿Ya tienes una cuenta?", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      TextButton(
        onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>singin()))
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