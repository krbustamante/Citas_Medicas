import 'dart:convert';
import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/historialpaciente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const perfil());

class perfil extends StatefulWidget {
  const perfil({super.key});
  @override
  State<perfil> createState() => _perfilState();
}

class _perfilState extends State<perfil> {
String msg = '';
final _formkey = GlobalKey<FormState>();

TextEditingController nombre_txt = TextEditingController();
TextEditingController apellido_txt = TextEditingController();
TextEditingController email_txt = TextEditingController();
TextEditingController edad_txt = TextEditingController();
TextEditingController direccion_txt =  TextEditingController();
TextEditingController pass_txt = TextEditingController();
 

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostrar_datos(); 

    nombre_txt = TextEditingController(text: load_nombre);
    apellido_txt = TextEditingController(text: load_apellido);
    email_txt = TextEditingController(text: load_email);
    edad_txt = TextEditingController(text: load_edad);
    direccion_txt = TextEditingController(text: load_direccion);
    pass_txt = TextEditingController(text: load_password);
  }

bool? load_logged = false; 
String? load_email = '';
String? load_password = '';
String? load_nombre = '';
String? load_ID_Usuario = '';
String? load_apellido = '';
String? load_edad = '';
String? load_direccion = '';

Future<void> mostrar_datos() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  setState(() {
    load_logged =  prefs.getBool("logged");
    load_email =  prefs.getString("email");
    load_password =  prefs.getString("password");
    load_nombre =  prefs.getString("nombre");
    load_ID_Usuario = prefs.getString("ID_Usuario");
    load_apellido = prefs.getString("apellido");
    load_edad = prefs.getString("edad");
    load_direccion = prefs.getString("direccion"); 
  });
}


void editData() {
    var url=Uri.parse('http://krbustamante.byethost7.com/php/editdata.php');
    http.post(url,body: {
      "ID_Usuario": load_ID_Usuario.toString(),
      "nombre": load_nombre,
      "apellido": load_apellido,
      "email": load_email,
      "direccion": direccion_txt.text,
      "password": pass_txt.text,
      "edad": edad_txt.text,
    });

    setState(() {
      msg="Cuenta Actualizada";
    });
    
    Navigator.push(context,MaterialPageRoute(builder: (context)=>historial()));
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        appBar: AppBar(         
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>historial()));
                }, 
              );
            },
          ),       
          centerTitle: true,
          title: Text("Editar Perfil"),       
        ),
        body: Container( //Creamos un contenedor
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // ignore: sort_child_properties_last
          child: Form( //centramos el contenido
            key: _formkey,
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [ //creamos una lista que pondra mas widgets uno tras otro
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: const Text("Editar Perfil",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ), 
                SizedBox(height: 10.0,),
                Text("Nombre: "),
                TextField(
                  enabled: false,
                  controller: nombre_txt,
                  decoration: InputDecoration(
                    labelText: load_nombre,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Apellido:"),
                TextField(
                  controller: apellido_txt,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: load_apellido,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),                 
                ),
                SizedBox(height: 10.0,),
                Text("Correo electrónico: "),
                TextField(
                  controller: email_txt,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: load_email,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),               
                ),                
                SizedBox(height: 10.0,),
                Text("Edad: "),
                TextFormField(
                  controller: edad_txt,
                  decoration: InputDecoration(
                    labelText: load_edad,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu edad";
                    } else {
                      return null;
                    }
                  },
                ),  
                SizedBox(height: 10.0,),
                Text("Direccion"),
                TextFormField(
                  controller: direccion_txt,
                  decoration: InputDecoration(
                    labelText: load_direccion,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa tu dirección";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10.0,),
                Text("Contraseña: "),
                TextFormField(
                  controller: pass_txt,
                  decoration: InputDecoration(
                    labelText: load_password,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Ingresa una contraseña";
                    } else {
                      return null;
                    }
                  },
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("¿Ya tienes una cuenta? ", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () { 
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>login()));                       
                      },
                    //Evento del boton
                      child: Text("Inicia Sesion"), 
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 18, 4, 150),
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero, // and this
                      ),
                      ),
                  ],
                ),
                mensaje(),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                  child: ElevatedButton( //Boton con estilos ya establecidos
                  onPressed: () {
                    if(_formkey.currentState!.validate()) { 
                      setState(() {
                        msg="Verificando datos...";
                      });                   
                      editData();
                      logout();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>login()));  
                    }
                  }, //Evento del boton
                  child: Text('Actualizar Datos'), //Texto del boton
                  style: ElevatedButton.styleFrom( //Definimos estilos
                    backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
                  ),
                  ),
                )
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

  Widget mensaje() { 
    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0);
    return Text(msg,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
