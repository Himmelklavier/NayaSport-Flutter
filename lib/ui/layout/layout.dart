import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:prueba/ui/pages/router.dart';
import 'package:prueba/ui/pages/widgets/naya_navigation_bar.dart';
import 'package:prueba/ui/providers/selected_screen_provider.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}


class _LayoutPageState extends State<LayoutPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final selectedScreenProvider = Provider.of<SelectedScreenProvider>(context);
    const String title = 'Naya Sport Store';

    final List<BottomNavigationBarItem> itemsNayaNavBar = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.storefront),
        label: 'Tienda',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Carrito compras',
      ),
    
    ];

    return MaterialApp(
      title: 'Naya Sport Store',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset('assets/logo2.svg'),
              const SizedBox(width: 10.0),
              const Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 52, 187, 255),
        ),
        body: screens[selectedScreenProvider.selectedIndex],
        bottomNavigationBar: NayaNavigationBar(
          items: itemsNayaNavBar,
          onItemSelected: (int index) {
            Provider.of<SelectedScreenProvider>(context, listen: false)
                .updateSelectedIndex(index);
          },
        ),
      ),
    );
  }
}
