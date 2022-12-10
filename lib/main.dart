import 'dart:convert';
import 'package:citas_medicas/pages/historialpaciente.dart';
import 'package:citas_medicas/pages/singin.dart';
import 'package:flutter/material.dart'; //Importamos el material.dart  
import 'package:citas_medicas/pages/lostpassword.dart'; 
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart'; 

// Atajo para crear esqueleto: mateapp 

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: login() ,
    ),
  );
}


class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}


class _loginState extends State<login> {

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: "Inicia Sesión",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container( //Creamos un contenedor
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          
          child: Form( //centramos el contenido
            key: _formkey,
            child: ListView( //Creamos un contenedor que va poder hacer scroll
              children: <Widget> [
                head(),
                headimg(),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: controllerEmail,
                  autocorrect: true,
                  keyboardType:TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) => value!.isEmpty || !value.contains("@")
                  ? "ingresa un correo válido"
                  : null,
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: controllerPass,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Contraseña",
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText=!_obscureText;
                        });

                      },
                      child: Icon(_obscureText 
                      ? Icons.visibility 
                      : Icons.visibility_off),
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
                SizedBox(height: 10.0,),
                passforgot(context),
                btnlogin(context), 
                mensaje(),
                registrate(context),     
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

TextEditingController controllerEmail = new TextEditingController();
TextEditingController controllerPass = new TextEditingController();

String msg = '';
bool _obscureText = true;
bool _status = true;

Future<void> _login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.post(Uri.parse('http://krbustamante.byethost7.com/php/login.php'), 
  body: {
    "email": controllerEmail.text,
    "password": controllerPass.text,
  });
  var datauser = json.decode(response.body);

if(datauser.length==0){
  setState(() {
    msg="Email o Contraseña Incorrectos";
    _status = false;
    prefs.setBool("logged", false);
  });
}else {
  if (datauser[0]['rol'] == 'paciente') { 
    setState(() {
      _status = true; 
      msg="Sesión Iniciada correctamente";

      prefs.setBool("logged", true);
      prefs.setString("email", controllerEmail.text);
      prefs.setString("password", controllerPass.text);
      prefs.setString("nombre", datauser[0]['nombre']);
      prefs.setString("ID_Usuario", datauser[0]['ID_Usuario']);
      prefs.setString("apellido", datauser[0]['apellido']);
      prefs.setString("edad", datauser[0]['edad']);
      prefs.setString("direccion", datauser[0]['direccion']);
      msg="Sesión guardada";
    });

    bool logged = true;
    String nombre = datauser[0]['nombre'];
    print("registrando: " +datauser[0]['ID_Usuario']);
    guardar_datos(logged,controllerEmail.text,controllerPass.text, nombre);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>historial()));
    }
} 
}

Future<void> guardar_datos(bool logged, String email, String password, String nombre) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('logged', logged);
  await prefs.setString('email', email);
  await prefs.setString('password', password);
  await prefs.setString('Nombre', nombre);
}

bool? load_logged = false; 
String? load_email = '';
String? load_password = '';
String? load_nombre = '';

Future<void> mostrar_datos() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  load_logged = await prefs.getBool("logged");
  load_email = await prefs.getString("email");
  load_password = await prefs.getString("password");
  load_nombre = await prefs.getString("nombre");

  print(load_email.toString());
  if(load_logged != false) {
    if(load_logged != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>historial()));
    }
  }
}
  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }


Widget head() {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0), //Padding con los valores left, top, rigt, button
    //Con child puedes poner un elemento
    child: Text("Inicia Sesión", style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
  );
}
Widget headimg() {
  return Container(
    padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
    child: Image.network("https://umburoff.sirv.com/Images/img_311846.png"), //Imagen de internet
  );
}



Widget btnlogin(context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
    child: ElevatedButton( //Boton con estilos ya establecidos
      onPressed: () {
        if(_formkey.currentState!.validate()) {
          final snackBar=SnackBar(content: Text('Iniciando Sesión'));
          _login();  
          setState(() {
            msg="Verificando datos...";
          }); 
        }
      }, //Evento del boton
      child: Text('Iniciar Sesión'), //Texto del boton
      style: ElevatedButton.styleFrom( //Definimos estilos
        backgroundColor: Color.fromARGB(255, 0, 164, 65), //Color del boton
      ),
    ),
  );
}

Widget mensaje() { 
  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0);
  return Text(msg,style: TextStyle(fontSize: 13.0,color: Colors.red),textAlign: TextAlign.center,);
}
Widget passforgot(context) {
  return TextButton( //boton sin estilos
    onPressed: () => {

     

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>lostpass()))
      }, //Evento del boton

    child: Text("¿Olvidaste tu Contraseña?"),
    style: TextButton.styleFrom(
      primary: Color.fromARGB(255, 18, 4, 150),
      minimumSize: Size.zero, // Eliminamos el padding del boton
      padding: EdgeInsets.zero, // Eliminamos padding
    ),
  );
}
Widget registrate(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("¿No tienes una cuenta?", style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      TextButton(
        onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>singin()))
        }, //Evento del boton
        child: Text("Registrate"),
        style: TextButton.styleFrom(
          primary: Color.fromARGB(255, 18, 4, 150),
          minimumSize: Size.zero, // Set this
          padding: EdgeInsets.zero, // and this
        ),
        ),
    ],
  );
}

}
