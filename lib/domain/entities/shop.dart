class Shop {
  final  String nombre;
  final int cantidad;
  final dynamic precio;
  final int idProducto;

  Shop(
      {required this.nombre,
      required this.cantidad,
      required this.precio,
      required this.idProducto});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      nombre: json['nombre'].toString(),
      idProducto: int.parse(json['idProducto'].toString()),
      cantidad: int.parse(json['cantidad'].toString()),
      precio: json['precio'],
    );
  }
}
