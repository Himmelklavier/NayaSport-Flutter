// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/ui/pages/shop/widgets/shop_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListViewShop extends StatefulWidget {
  const ListViewShop({super.key});

  @override
  State<ListViewShop> createState() => _ListViewShopState();
}

class _ListViewShopState extends State<ListViewShop> {
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FutureBuilder(
          future: shopService.getAllShop(idUsuario!),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            print('snap ${snapshot.data!.length}');
            print('dTA ${snapshot.data!}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.data!.isEmpty) {
              return const Text('No hay productos en el carrito');
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ShopCard(
                        shop: snapshot.data![index],
                        id: index,
                        pressDelete: () async {
                          var res = await shopService.deleteProductShop(
                              snapshot.data![index].idProducto, 1);
                          print(res);
                        });
                  });
            }
          }),
      FutureBuilder(
          future: shopService.totalShop(idUsuario!),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            print('snaptotal ${snapshot.data!}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total :',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('${snapshot.data!}'),
                  ]);
            }
          })
    ]);
  }
}
