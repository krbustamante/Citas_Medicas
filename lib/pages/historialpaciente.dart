import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/newcita.dart';
import 'package:citas_medicas/pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class historial extends StatefulWidget {
  const historial({super.key});

  @override
  State<historial> createState() => _historialState();
}

class _historialState extends State<historial> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostrar_datos();
    _recuperarCitas();
  }

  bool? load_logged = false;
  String? load_email = '';
  String? load_password = '';
  String? load_nombre = '';
  String? load_IDUsuario = '';
  String? load_IDCita = '';

  Future<void> mostrar_datos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      load_logged = prefs.getBool("logged");
      load_email = prefs.getString("email");
      load_password = prefs.getString("password");
      load_nombre = prefs.getString("nombre");
      load_IDUsuario = prefs.getString("ID_Usuario");
      load_IDCita = prefs.getString("ID_Cita");
    });
    print("ID usuario" + load_IDUsuario.toString());
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        listTileTheme: const ListTileThemeData(
          tileColor: Colors.white,
          textColor: Colors.black,
          iconColor: Colors.black,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Citas Médicas"),
        ),
        drawer: Drawer(
          child: Container(
            child: Center(
                child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                          ),
                          width: 90,
                          height: 90,
                          child: const CircleAvatar(
                            //border
                            radius: 100,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://umburoff.sirv.com/Images/luffy.jpg'),
                            ),
                          ),
                        ),
                        Text(
                          load_nombre.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          load_email.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Perfil'),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const perfil()))
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.medical_information),
                    title: const Text('Historial'),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const historial()))
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Salir'),
                    onTap: () => {
                      logout(),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login()))
                    },
                  ),
                ),
              ],
            )),
          ),
        ),
        body: Container(
          
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
          //Creamos un contenedor
          child: ListView.builder(
            itemCount: vueltas,
            itemBuilder: (context, index) {
              return ListTile( 
                title: Text(hora + "     " + fecha),
                subtitle: Text(consultorio + "     " + doctor),
                leading: const Icon(
                  Icons.access_time,
                  size: 36.0,
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => newcita()));
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  var datauser;
  var hora = '', fecha = "", consultorio = "", doctor = "";
  
  Future<void> _recuperarCitas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
        Uri.parse('http://krbustamante.byethost7.com/php/get_by_cita.php'),
        body: {
          "ID_Paciente": load_IDUsuario.toString(),
        });

    setState(() {
      datauser = json.decode(response.body);
    });
    crearlistas();
  }

  int vueltas = 0;
  crearlistas() {
    for (int i = 0; i < datauser.length; i++) {
      setState(() {
        fecha = datauser[i]["fecha"];
        hora = datauser[i]["hora"];
        consultorio = datauser[i]["consultorio"];
        doctor = datauser[i]["doctor"];
      });
      vueltas++;
      print(datauser.length);
    }
  }

  Widget btncita(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 95, vertical: 5),
      child: ElevatedButton(
        //Boton con estilos ya establecidos
        onPressed: () {
          crearlistas();
        }, //Evento del boton
        child: const Text('Solicitar Cita'), //Texto del boton
        style: ElevatedButton.styleFrom(
          //Definimos estilos
          backgroundColor:
              const Color.fromARGB(255, 0, 164, 65), //Color del boton
        ),
      ),
    );
  }
}
