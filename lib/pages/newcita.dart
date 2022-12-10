import 'dart:convert';
import 'package:citas_medicas/main.dart';
import 'package:citas_medicas/pages/historialpaciente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_picker/date_time_picker.dart';

class newcita extends StatefulWidget {
  @override
  State<newcita> createState() => _newcitaState();
}

class _newcitaState extends State<newcita> {
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

  var datauser;
  

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
  }

  String msg = '';
  String id = '';
  final _formkey = GlobalKey<FormState>();

  Future<void> SaveData(fecha, hora, doctor, consultorio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse('http://krbustamante.byethost7.com/php/addcita.php'),
        body: {
          "fecha": fecha,
          "hora": hora,
          "consultorio" : consultorio,
          "doctor" : doctor,
        });

    setState(() {
      msg = "Creando Cita Medica";
    });
 

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const historial()));
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
                          MaterialPageRoute(
                              builder: (context) => const login()));
                    },
                  );
                },
              ),
              centerTitle: true,
              title: const Text("Crear nueva cita"),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Form(
                  key: _formkey,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(
                        height: 50.0,
                      ),
                      const Text(
                        "Selecciona una fecha y una hora para tu cita, tu doctor y tu consultorio los verás en tu historial.",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
        
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Fecha',
                        timeLabelText: "Hora",
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }
                          return true;
                        },
                        onChanged: (val) => SplitData(val),
                        validator: (val) {
                          SplitData(val.toString());
                          return null;
                        },
                        onSaved: (val) => SplitData(val.toString()),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      menuDoctores(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      menuConsultorios(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      mensaje(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      btncreatecita(),
                    ],
                  )),
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
            )));
  }
String hora = '', fecha = "";
  SplitData(String data) {
    final splitted = data.split(' ');
    fecha = splitted[0];
    hora = splitted[1];

  }


var consultorios = [
  "Odontología",
  "Ginecología",
  "Pediatría",
  "Podología",
  "Consulta General"
  ];

String selectedConsultorio = '';

  Widget menuConsultorios() {
    return DropdownButton(
               
              // Initial Value
              value: selectedConsultorio,
               
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),   
               
              // Array list of items
              items: consultorios.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  selectedConsultorio = newValue!;
                });
              },
            );
  }

var doctores = [
  "Jesus Marqués",
  "Coral Lusia",
  "Luis Gomez",
  "Pacheco Flores",
  ];

String selectedDoctor = '';

  Widget menuDoctores() {
    return DropdownButton(
      value: selectedDoctor,
        
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      // Array list of items
      items: consultorios.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          selectedDoctor = newValue!;
        });
      },
    );
  }

  Widget mensaje() {
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 0, vertical: 0);
    return Text(
      msg,
      style: const TextStyle(fontSize: 13.0, color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  Widget btncreatecita() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 5),
      child: ElevatedButton(
        //Boton con estilos ya establecidos
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            setState(() {
              msg = "Verificando datos...";
            });
            SaveData(fecha, hora, selectedConsultorio, selectedDoctor);
          }
        }, //Evento del boton
        child: const Text('Crear cita'), //Texto del boton
        style: ElevatedButton.styleFrom(
          //Definimos estilos
          backgroundColor:
              const Color.fromARGB(255, 0, 164, 65), //Color del boton
        ),
      ),
    );
  }
}
