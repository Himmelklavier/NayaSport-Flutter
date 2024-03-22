import 'package:flutter/material.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/dashboard/dashboard_page.dart';
import 'package:prueba/ui/pages/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                const Text(
                  'Hola admin ',
                 style:TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 138, 156),

                  )
                ),
                ElevatedButton(
                  onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const DashboardPage()));
                },
                child: const Text("Crear un producto"))
              ],
            ),
          ),
         
        ));
  }
}
