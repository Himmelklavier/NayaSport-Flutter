// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyShop extends StatefulWidget {
  const BuyShop({super.key});

  @override
  State<BuyShop> createState() => _BuyShopState();
}

class _BuyShopState extends State<BuyShop> {
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

  Future<int?> _buy(BuildContext context) async {

    var response = await shopService.deleteAllShop(idUsuario!);
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
                      MaterialPageRoute(builder: (context) => const LayoutPage()),
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
    return ElevatedButton(
        onPressed: () async {
          var res = await _buy(context);
           res == 200 ? _alertBuy(context) : const Text('Error');
        },
        child: const Text('Realizar compra'));
  }
}
