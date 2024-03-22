// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/domain/entities/uniforme.dart';
import 'package:prueba/ui/pages/products/widgets/button_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final Uniforme uniforme;
  final int id;

  const ProductCard({Key? key, required this.uniforme, required this.id})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var shopService = GetIt.I<ShopServiceImpl>();

  late final int? idUsuario;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idUsuario = prefs.getInt('idUsuario');
    });
  }

  int cantidad = 0;
  late int res;

  final Map<String, dynamic> success = {
    "icon": const Icon(
      Icons.check,
      color: Colors.green,
      size: 30.0,
    ),
    "titleMessage": "Agregado con exito",
  };

  final Map<String, dynamic> reject = {
    "icon": const Icon(
      Icons.error,
      color: Colors.red,
      size: 30.0,
    ),
    "titleMessage": "Error al agregar al producto",
  };

  void _alertProductCard(BuildContext context, info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: info['icon'],
          title: Text(info['titleMessage']),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              child: Column(children: [
            ListTile(
              title: Text(widget.uniforme.nombre.toString()),
              subtitle: Text(widget.uniforme.precioVenta.toString()),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonCard(
                  text: '-',
                  onPress: () {
                    setState(() {
                      cantidad > 0 ? cantidad-- : cantidad;
                    });
                  },
                ),
                Text(cantidad.toString()),
                ButtonCard(
                  text: '+',
                  onPress: () {
                    setState(() {
                      cantidad++;
                    });
                  },
                ),
              ],
            )),
          ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.amber),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: const Text('Agregar al Carrito'),
                  onPressed: () async {
                    res = (await shopService.addProductShop(
                        widget.uniforme.idProducto!, idUsuario!, cantidad))!;
                    print('res cart : $res');
                    if (res == 200) {
                      _alertProductCard(context, success);
                    } else {
                      _alertProductCard(context, reject);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

Uint8List _extractAndDecodeBase64Image(dynamic imagenData) {
  if (imagenData is String && imagenData.isNotEmpty) {
    try {
      debugPrint('imagen es string y no es empty, decodificando');
      return base64.decode(imagenData);
    } catch (error) {
      print('Error decoding Base64 image: $error');
      return Uint8List(0); // Empty list on error
    }
  } else {
    debugPrint('imagen no es String o is empty');
    return Uint8List(0); // Empty list if imagenData is not a String
  }
}
