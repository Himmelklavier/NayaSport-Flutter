// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/ui/pages/shop/widgets/buy_shop.dart';
import 'package:prueba/ui/pages/shop/widgets/list_view_shop.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  
  @override
  void initState() {
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
      ),
      body: const Column(
         children: [
          ListViewShop(),
          BuyShop(),
         ]
     ));
  }
}
