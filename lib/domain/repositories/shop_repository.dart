import 'package:prueba/domain/entities/Shop.dart';

abstract class ShopRepository {
  Future<int?> addProductShop(int idProducto, int idUsuario, int cantidad);
  Future<int?> deleteProductShop(int idProducto, int idUsuario);
  Future<int?> deleteAllShop(int idUsuario);
  Future<double> totalShop(int idUsuario);
  Future<List<Shop>> getAllShop(int idUsuario);
}
