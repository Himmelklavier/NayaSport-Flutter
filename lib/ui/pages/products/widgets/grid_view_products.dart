// ignore_for_file: avoid_print, unused_import

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/products/products_service_impl.dart';
import 'package:prueba/domain/entities/uniforme.dart';
import 'package:prueba/ui/pages/products/widgets/product_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GridViewProducts extends StatefulWidget {
  const GridViewProducts({super.key});
  @override
  State<GridViewProducts> createState() => _GridViewProductsState();
}

class _GridViewProductsState extends State<GridViewProducts> {
  var productsService = GetIt.I<ProductsServiceImpl>();
  late final Future<List<Uniforme>> productsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productsService.getAllProducts(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          List<dynamic> data = snapshot.data as List<dynamic>;
          return ResponsiveGridList(
            minItemWidth: 200,
            children: data.asMap().entries.map((entry) {
              int index = entry.key;
              var uniforme = entry.value;
              return ProductCard(id: index, uniforme: uniforme);
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
