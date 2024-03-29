//authWrapper.dart
import 'package:flutter/material.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(), // Verifica si el usuario está autenticado
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se verifica la autenticación
          return const CircularProgressIndicator();
        } else {
          // Basado en el resultado de la verificación, muestra la página apropiada
          final bool isAuthenticated = snapshot.data ?? false;
          return isAuthenticated
              ? const LayoutPage(index: 0)
              : const LoginPage();
        }
      },
    );
  }

  Future<bool> isAuthenticated() async {
    // Obtén una instancia de SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('accessToken')) {
      final accessToken = prefs.getString('accessToken');
      // ignore: avoid_print
      print('AccessToken: $accessToken');
      return true;
    } else {
      return false;
    }
  }
}
