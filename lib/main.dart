// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';
import 'package:prueba/dependency_injection/services_register.dart';
import 'package:prueba/ui/pages/router.dart';
import 'package:prueba/ui/providers/selected_screen_provider.dart';

void main() {
  // GetIt.I.registerSingleton<ShopServiceImpl>(ShopServiceImpl());
  injectorServices();
  runApp(
    ChangeNotifierProvider<SelectedScreenProvider>(
      create: (context) => SelectedScreenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NayaSport',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRouter(),
    );
  }
}
