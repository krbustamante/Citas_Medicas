import 'package:flutter/material.dart';

void main() => runApp(const perfil());

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
      ),
      body: Container( //Creamos un contenedor
          child: Center( //centramos el contenido
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                header(),
                Nombre(),
                Apellido(),
                Correo_Electronico(),
                Edad(),
                Direccion(),
                Contrasenia(),
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

Widget header() {
  return Container( //centramos el contenido                                      
    child: ListView( //Creamos un contenedor que va poder hacer scroll
      children: <Widget> [ 
        Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          width: 100,
          height: 100,
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://umburoff.sirv.com/Images/luffy.jpg",),
          )               
        ),
        const Text("krbustamante", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),textAlign: TextAlign.center,),
      ],
    ),
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

