import 'package:flutter/material.dart';

void main() => runApp(const historial());

class historial extends StatelessWidget {
  const historial({super.key});

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
}