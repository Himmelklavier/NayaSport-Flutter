// ignore_for_file: avoid_print, unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/ui/pages/shop/widgets/buy_shop.dart';
import 'package:prueba/ui/pages/shop/widgets/list_view_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int? idUsuario;
  bool idExist = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idUsuario = prefs.getInt('idUsuario');
      print('idUsuarioShopePage->$idUsuario');
    });
    if (idUsuario != null) {
      idExist = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tienda'),
        ),
        body: Center(
            child: !idExist
                ? const CircularProgressIndicator()
                : _columnWidgets(context, idUsuario!)));
  }

  Widget _columnWidgets(BuildContext context, int idUsuario) {
    return Column(children: [
      ListViewShop(idUsuario: idUsuario),
      BuyShop(idUsuario: idUsuario),
    ]);
  }
}
