import 'package:citas_medicas/pages/historialpaciente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const perfil());

class perfil extends StatefulWidget {
  const perfil({super.key});

  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(
          title: Text("Editar Perfil"),
        ),
        body: Container( //Creamos un contenedor
            child: Center( //centramos el contenido
              child: ListView( //Creamos un contenedor que va poder hacer scroll
                children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                
                  Nombre(),
                  Apellido(),
                  Correo_Electronico(),
                  Edad(),
                  Direccion(),
                  Contrasenia(),
                  btnsave(context),
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
}



Widget Nombre() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
      hintText: "Contraseña",
      filled: true,
      ),
    ),
  );
}

Widget btnsave(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>historial()))
      }, //Evento del boton
      child: Text('Guardar Cambios'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}