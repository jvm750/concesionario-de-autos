import 'package:flutter/material.dart';
import 'package:dam_u2_proyecto2/listaCarros.dart';
import 'package:dam_u2_proyecto2/carros.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Eliminar extends StatefulWidget {
  const Eliminar({Key? key}) : super(key: key);

  @override
  State<Eliminar> createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
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

  void _eliminarCarro(int index) {
    setState(() {
      _listaCarros.data.removeAt(index);
      _listaCarros.guardarArchivo();
    });
  }

  void _mostrarDialogoConfirmacion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content: Text('¿Estás seguro de que quieres eliminar este carro?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                _eliminarCarro(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Carro',style: TextStyle(color: Colors.limeAccent, fontSize: 15)),
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
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _mostrarDialogoConfirmacion(index),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
