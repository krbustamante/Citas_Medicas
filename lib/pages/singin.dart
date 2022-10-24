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
                Apellido()
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
  return TextField(
      decoration: InputDecoration(
      hintText: "Nombre",
      fillColor: Colors.white,
      filled: true,
      ),
    );
}

Widget Apellido() {
  return TextField(
      decoration: InputDecoration(
      hintText: "Apellido",
      fillColor: Colors.white,
      filled: true,
      ),
    );
}