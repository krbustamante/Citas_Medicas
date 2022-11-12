import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/perfil.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(const historial());

class historial extends StatefulWidget {
  const historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold (  
          appBar: AppBar(
            title: Text("Citas Médicas"),
          ),          
          drawer: Drawer(
            child: Container(
              child: Center( //centramos el contenido
                child: ListView( //Creamos un contenedor que va poder hacer scroll
                  children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Container( //centramos el contenido                                      
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
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('Perfil'),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>perfil())
                          )
                        }, 
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.medical_information),
                        title: Text('Historial'),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>historial())
                          )
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Salir'),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>login()))
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
          body: Container( //Creamos un contenedor
            child: Center( //centramos el contenido
              child: ListView( //Creamos un contenedor que va poder hacer scroll
                children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                  listado(context),
                  btncita(context),
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

Future<List> getData() async {
  final response = await http.get(Uri.parse('http://krbustamante.byethost7.com/php/getdata.php'));
  return json.decode(response.body);
}
  
Widget listado(context) {
  return ListTile(
      title: Text("10:40am" + "     " + "05/10/2023"),
      subtitle: Text("Odontología" + "     " + "Doctor"),
      leading: Icon(Icons.access_time, size: 36.0,),
  );
}

Widget btncita(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 95, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>historial()))
      }, //Evento del boton
      child: Text('Solicitar Cita'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}
}
