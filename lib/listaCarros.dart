import 'package:dam_u2_proyecto2/carros.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaCarros{
  List<Carro> data =[];

  Carro toCarro(String cod){
    List res = cod.split("&&");
    Carro ca = Carro(
        placa: res[0],
        modelo: res[1],
        marca: res[2],
        ano: res[3],
        precio: res[4]
    );
    return ca;
  }

  Future<bool> guardarArchivo() async{
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    data.forEach((element) {
      buffer.add(element.toString());
    });
    almacen.setStringList("buffer", buffer);
    return true;
  }
  Future cargarDatos() async{
    SharedPreferences almacen = await SharedPreferences.getInstance();
    List<String> buffer = [];
    buffer =almacen.getStringList("buffer") ?? [];
    buffer.forEach((element) {
      data.add(toCarro(element));
    });
  }
  Future<bool> borrarAlmacen() async{
    SharedPreferences almacen = await SharedPreferences.getInstance();
    almacen.remove("buffer");
    return true;
  }
  void nuevo(Carro ca){
    data.add(ca);
  }

  void actualizar(Carro ca, int pos){
    data[pos] =ca;
  }

  void eliminar(int pos){
    data.removeAt(pos);
  }
  Carro? buscarPorPlaca(String placa) {
    return data.firstWhere((carro) => carro.placa == placa);
  }

  void actualizarCarro(Carro carroActualizado) {
    int index = data.indexWhere((carro) => carro.placa == carroActualizado.placa);
    if (index != -1) {
      data[index] = carroActualizado;
    }
  }

}