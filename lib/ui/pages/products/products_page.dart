// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:prueba/ui/pages/products/widgets/grid_view_products.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uniformes'),
      ),
      body: const GridViewProducts(), // Implementa tu cuadrícula o lista aquí
    );
  }
}
