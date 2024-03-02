import 'package:flutter/material.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_add_product/dashboard_add_product.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_page.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

const List<Widget> pageSelected = <Widget>[
  DashboardPage(),
  DashboardAddProduct(),
];

class _LayoutPageState extends State<LayoutPage> {
  int index = 0;

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
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("NayaSport - Dashboard"),
          ),
          body: const Center(
            child:  Text("holi"),
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: 'Añadir producto')
              ],
              currentIndex: index,
              onTap: (int indexSelected) => setState(() {
                    index = indexSelected;
                  })),
        ));
  }
}
