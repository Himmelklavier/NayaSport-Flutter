import 'package:flutter/material.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_add_product/dashboard_add_product.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_page.dart';
import 'package:prueba/ui/pages/home/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String dashboard = '/dashboard';
   static const String addProduct = '/addproduct';
}

Map<String, Widget Function(BuildContext)> appRouter() {
  return {
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.dashboard: (context) => const DashboardPage(),
    AppRoutes.addProduct: (context) => const DashboardAddProduct()
  };
}