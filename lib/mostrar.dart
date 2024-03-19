import 'package:dam_u2_proyecto2/actualizar.dart';
import 'package:dam_u2_proyecto2/capturar.dart';
import 'package:dam_u2_proyecto2/eliminar.dart';
import 'package:dam_u2_proyecto2/main.dart'; // Asegúrate de que este import es correcto y necesario
import 'package:flutter/material.dart';
import 'package:dam_u2_proyecto2/carros.dart';
import 'package:dam_u2_proyecto2/listaCarros.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mostrar(), // Página inicial
  ));
}

class Mostrar extends StatefulWidget {
  const Mostrar({Key? key}) : super(key: key);

  @override
  _MostrarState createState() => _MostrarState();
}

class _MostrarState extends State<Mostrar> {
  final ListaCarros _listaCarros = ListaCarros();

  @override
  void initState() {
    super.initState();
    _cargarCarros();
  }

  Future<void> _cargarCarros() async {
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = almacen.getStringList("buffer") ?? [];
    List<Carro> tempData = [];
    for (String rawCar in buffer) {
      tempData.add(_listaCarros.toCarro(rawCar));
    }

    if (mounted) {
      setState(() {
        _listaCarros.data = tempData;
      });
    }
  }


  void _recargarLista() {
    _cargarCarros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Concesionaria de Autos', style: TextStyle(color: Colors.limeAccent)),
        backgroundColor: Colors.black54,
      ),
      drawer: _buildDrawer(context),
      body: ListView.builder(
    itemCount: _listaCarros.data.length,
      itemBuilder: (context, index) {
        Carro carro = _listaCarros.data[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.car_rental, color: Colors.blue),
            title: Text('${carro.marca} ${carro.modelo}'),
            subtitle: Text('Placa: ${carro.placa} - Año: ${carro.ano}'),
            trailing: Text('\$${carro.precio}'),
            isThreeLine: true,
          ),
        );
      },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recargarLista,
        tooltip: 'Recargar',
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.limeAccent,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Mostrar())),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Capturar'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Capturar())),
          ),
          ListTile(
            leading: Icon(Icons.arrow_circle_up),
            title: Text('Actualizar'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Actualizar())),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Eliminar'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Eliminar())),
          ),
          ListTile(
            leading: Icon(Icons.door_back_door_outlined),
            title: Text('Cerrar sesión'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), // Asegúrate de que LoginPage es correcto y existe
          ),
        ],
      ),
    );
  }
}
