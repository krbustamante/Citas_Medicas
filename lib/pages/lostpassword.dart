import 'package:citas_medicas/main.dart';
import 'package:flutter/material.dart';

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