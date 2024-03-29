// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/ui/layout/layout.dart';

class BuyShop extends StatefulWidget {
  final int idUsuario;
  const BuyShop({super.key, required this.idUsuario});

  @override
  State<BuyShop> createState() => _BuyShopState();
}

class _BuyShopState extends State<BuyShop> {
  var shopService = GetIt.I<ShopServiceImpl>();

  @override
  void initState() {
    super.initState();
    print("idUsuarioBuyShop-> ${widget.idUsuario}");
  }

  Future<int?> _buy(BuildContext context) async {
    var response = await shopService.deleteAllShop(widget.idUsuario);
    return response;
  }

  void _alertBuy(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check,
            color: Colors.green,
            size: 30.0,
          ),
          title: const Text('Compra exitosa'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LayoutPage(index: 0)),
                );
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
    return Container(child: _shopButton(context));
  }

  Widget _shopButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var res = await _buy(context);
          res == 200 ? _alertBuy(context) : const Text('Error');
        },
        child: const Text('Realizar compra'));
  }
}
