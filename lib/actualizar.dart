import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'carros.dart';
import 'package:dam_u2_proyecto2/listaCarros.dart';

class Actualizar extends StatefulWidget {
  const Actualizar({Key? key}) : super(key: key);
  @override
  State<Actualizar> createState() => _ActualizarState();
}

class _ActualizarState extends State<Actualizar> {
  final TextEditingController _buscarPlacaController = TextEditingController();
  final ListaCarros _listaCarros = ListaCarros();
  @override

  void initState(){
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
  void _mostrarDialogoActualizar(Carro carro, int index) {
    final _modeloController = TextEditingController(text: carro.modelo);
    final _marcaController = TextEditingController(text: carro.marca);
    final _anoController = TextEditingController(text: carro.ano);
    final _precioController = TextEditingController(text: carro.precio);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar Carro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(controller: _modeloController, decoration: InputDecoration(labelText: 'Modelo')),
                TextField(controller: _marcaController, decoration: InputDecoration(labelText: 'Marca')),
                TextField(controller: _anoController, decoration: InputDecoration(labelText: 'Año')),
                TextField(controller: _precioController, decoration: InputDecoration(labelText: 'Precio')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Actualizar'),
              onPressed: () {
                setState(() {
                  carro.modelo = _modeloController.text;
                  carro.marca = _marcaController.text;
                  carro.ano = _anoController.text;
                  carro.precio = _precioController.text;
                  _listaCarros.actualizar(carro, index);
                  _listaCarros.guardarArchivo();
                });
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Carro',style: TextStyle(color: Colors.limeAccent, fontSize: 15)),
        backgroundColor: Colors.black54,
      ),
      body: ListView.builder(
        itemCount: _listaCarros.data.length,
        itemBuilder: (context, index) {
          Carro carro = _listaCarros.data[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.car_rental, color: Colors.blue),
              title: Text('${carro.marca} ${carro.modelo}'),
              subtitle: Text('Placa: ${carro.placa} - Año: ${carro.ano}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _mostrarDialogoActualizar(carro, index),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
