// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/domain/entities/Shop.dart';

class ShopCard extends StatefulWidget {
  final Shop shop;
  final int id;
  final VoidCallback? pressDelete;

  const ShopCard(
      {super.key, required this.shop, required this.id, this.pressDelete});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(widget.shop.nombre),
              subtitle: Text(widget.shop.precio),
              trailing: Text(
                'Cantidad : ${widget.shop.cantidad}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          /* TextButton(
              onPressed: () {
                if (widget.pressDelete != null) {
                  widget.pressDelete!();
                }
              },
              child: const Icon(Icons.delete,
                  color: Color.fromARGB(255, 240, 0, 0))) */
        ],
      ),
    );
  }
}
