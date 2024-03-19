class Carro{
  String placa;
  String modelo;
  String marca;
  String ano;
  String precio;

  Carro({
    required this.placa,
    required this.modelo,
    required this.marca,
    required this.ano,
    required this.precio
  });

  String toString(){
    return "$placa&&$modelo&&$marca&&$ano&&$precio";
  }
}