// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/products/products_page.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_page.dart';
import 'package:prueba/ui/pages/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? rol;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rol = prefs.getInt('rol');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BackgroundWhite.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: rol == null
                ? const CircularProgressIndicator()
                : (rol == 1 ? _adminOptions(context) : _userOptions(context)),
          ),
        ));
  }
}

Widget _adminOptions(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text('Hola admin ',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 0, 138, 156),
          )),
      ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DashboardPage()));
          },
          child: const Text("Crear un producto")),
    ],
  );
}

Widget _userOptions(BuildContext context) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Image.asset(
      'assets/banner_home.png',
      width: MediaQuery.of(context).size.width,
      filterQuality: FilterQuality.high,
    ),
    const SizedBox(
      height: 5.0,
    ),
    const Text(
      'Bienvenidos a Nuestra Tienda de Uniformes Deportivos',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        color: Colors.cyan,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    ),
    const SizedBox(
      height: 35.0,
    ),
    ElevatedButton(
      onPressed: () {
        //Navigator.of(context).pushReplacementNamed(AppRoutes.products);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LayoutPage(
                      index: 2,
                    )));
      },
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.cyan),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)))),
      child: const Text('Tienda', style: (TextStyle(color: Colors.white))),
    ),
  ]);
}
