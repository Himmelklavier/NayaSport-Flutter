// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_add_product/dashboard_add_product.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_page.dart';
import 'package:prueba/ui/pages/home/home_page.dart';
import 'package:prueba/ui/pages/login/login_page.dart';
import 'package:prueba/ui/pages/login/widgets/auth_wrapper.dart';
import 'package:prueba/ui/pages/products/products_page.dart';
import 'package:prueba/ui/pages/register/register_page.dart';
import 'package:prueba/ui/pages/shop/shop_page.dart';

class AppRoutes {
  static const String layout = '/';
  static const String home = '/home';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String addProduct = '/addproduct';
  static const String shop = '/shop';
  static const String products = '/products';
}

Map<String, Widget Function(BuildContext)> appRouter() {
  return {
    AppRoutes.layout: (context) => const AuthenticationWrapper(),
    AppRoutes.home: (context) => const LoginPage(),
    AppRoutes.register: (context) => const RegisterPage(),
    AppRoutes.dashboard: (context) => const DashboardPage(),
    AppRoutes.addProduct: (context) => const DashboardAddProduct(),
    AppRoutes.shop: (context) => const ShopPage(),
    AppRoutes.products: (context) => const ProductsPage()
  };
}

const List<Widget> screens = <Widget>[
  HomePage(),
  ProductsPage(),
  ShopPage(),

  //DashboardPage(),

  //DashboardAddProduct(),
];
