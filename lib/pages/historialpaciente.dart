import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/perfil.dart'; 
import 'package:flutter/material.dart';

void main() => runApp(const historial());

class historial extends StatefulWidget {
  const historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {

  List <Cita> _citas = [
    Cita("10:25", "10/05/2022", "Odontologia"),
    Cita("11:40", "18/05/2022", "Odontologia"),
    Cita("12:25", "20/06/2022", "Odontologia"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

Widget listado(context) {
  return ListView.builder(
    itemCount: _citas.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(_citas[index].hora + " " + _citas[index].fecha),
        subtitle: Text(_citas[index].consultorio),
        
        trailing: Icon(Icons.arrow_forward_ios),
      );
    }
  );
}

class Cita {
  String hora;
  String fecha;
  String consultorio;

  Cita(this.hora, this.fecha, this.consultorio);
}

List<Cita> _citas = [];