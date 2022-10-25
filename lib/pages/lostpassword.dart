import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
}

Widget correo() {
  return Container(
    //padding horizontal y vertical
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Column( //contenedor columna para poner varios widgets consecutivos
      children: [ //hace una lista de varios widgeta
        //Campo Correo Electrónico
        TextField(  //Campo de Texto
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