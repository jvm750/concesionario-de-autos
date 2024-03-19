import 'package:dam_u2_proyecto2/listaCarros.dart';
import 'package:dam_u2_proyecto2/mostrar.dart';
import 'package:flutter/material.dart';
import 'package:dam_u2_proyecto2/carros.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Capturar extends StatefulWidget {
  const Capturar({Key? key}) : super(key: key);

  @override
  State<Capturar> createState() => _CapturarState();
}

class _CapturarState extends State<Capturar> {
  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _placa = TextEditingController();
  final TextEditingController _marca = TextEditingController();
  final TextEditingController _ano = TextEditingController();
  final TextEditingController _precio = TextEditingController();

  final ListaCarros listaCarros = ListaCarros();
  @override

  void initState() {
    super.initState();
    _cargarCarros(); // Cargar carros al iniciar
  }

  Future<void> _cargarCarros() async {
    await listaCarros.cargarDatos(); // Cargar datos de SharedPreferences
  }

  Future<void> _guardarCarro() async {
    final carro = Carro(
      placa: _placa.text,
      modelo: _modelo.text,
      marca: _marca.text,
      ano: _ano.text,
      precio: _precio.text,
    );

    listaCarros.nuevo(carro); // Agregar nuevo carro a la lista
    await listaCarros.guardarArchivo(); // Guardar la lista actualizada en SharedPreferences

    // Limpiar campos de texto
    _placa.clear();
    _modelo.clear();
    _marca.clear();
    _ano.clear();
    _precio.clear();

    // Mostrar SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Auto agregado')),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Concesionaria de Autos - Capturar', style: TextStyle(color: Colors.limeAccent, fontSize: 15)),
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: _placa,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Placa',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54))
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _modelo,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                labelText: 'Modelo',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54))
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _marca,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Marca',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
              ),
            ),SizedBox(height: 20,),
            TextField(
              controller: _ano,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Año',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54))
              ),
            ),SizedBox(height: 20,),
            TextField(
              controller: _precio,
              style: TextStyle(color: Colors.black54),
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Precio',
                  labelStyle: TextStyle(color: Colors.black54),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54))
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _guardarCarro,
              child: Text("Agregar", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.white;
                    return Colors.limeAccent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.limeAccent;
                    return Colors.white;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
