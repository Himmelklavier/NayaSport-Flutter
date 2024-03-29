// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba/domain/entities/uniforme.dart';
import 'package:prueba/domain/repositories/product_repository.dart';

class ProductsServiceImpl implements ProductRepository {
  final baseApi = "http://192.168.1.11:3001/api/productos";

  @override
  Future<List<Uniforme>> getAllProducts() async {
    final Uri url = Uri.parse('$baseApi/');
    final Map<String, String> headers = {'Content-type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      //print("response body-> ${response.body}");
      List<Uniforme> products =
          decodeData.map<Uniforme>((e) => Uniforme.fromJson(e)).toList();
      for (var product in products) {
        print('Imagen del producto: ${product.imagen}');
      }

      return products;
    } else {
      throw Exception('Error al obtener los productos: ${response.statusCode}');
    }
  }
}
