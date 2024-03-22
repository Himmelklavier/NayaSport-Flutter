import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba/domain/entities/Shop.dart';
import 'package:prueba/domain/repositories/shop_repository.dart';

class ShopServiceImpl implements ShopRepository {
  final baseApi = "http://192.168.0.3:3001/api/cart";

  @override
  Future<int?> addProductShop(
      int idProducto, int idUsuario, int cantidad) async {
    final Uri url = Uri.parse('$baseApi/addCart');
    final Map<String, String> headers = {'Content-type': 'application/json'};
    final Map<String, dynamic> data = {
      "idProducto": idProducto.toString(),
      "idUsuario": idUsuario.toString(),
      "cantidad": cantidad.toString()
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      throw Exception('Error al añadir el producto: ${response.statusCode}');
    }
  }

  @override
  Future<double> totalShop(int idUsuario) async {
    final Uri url = Uri.parse('$baseApi/total/$idUsuario');
    final Map<String, String> headers = {'Content-type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['total'] == null) {
        return 0.0;
      } else {
        return double.parse(jsonDecode(response.body)['total']);
      }
    } else {
      throw Exception('Error al procesar tu compra: ${response.statusCode}');
    }
  }

  @override
  Future<int?> deleteAllShop(int idUsuario) async {
    final Uri url = Uri.parse('$baseApi/deleteCart/$idUsuario');
    final Map<String, String> headers = {'Content-type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  @override
  Future<int?> deleteProductShop(int idProducto, int idUsuario) {
    // TODO: implement deleteProductProductShop
    throw UnimplementedError();
  }

  @override
  Future<List<Shop>> getAllShop(int idUsuario) async {
    final Uri url = Uri.parse('$baseApi/allCart/$idUsuario');
    final Map<String, String> headers = {'Content-type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> dataDecode = json.decode(response.body);
      List<Shop> shopList =
          dataDecode.map((json) => Shop.fromJson(json)).toList();

      return shopList;
    } else {
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }
}
