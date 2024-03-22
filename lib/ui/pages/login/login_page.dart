// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba/data/repositories/login/auth_repository_impl.dart';
import 'package:prueba/data/services/login/auth_service_impl.dart';
import 'package:prueba/domain/usecases/login/login_use_case.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/home/home_page.dart';
import 'package:prueba/ui/pages/products/products_page.dart';
import 'package:prueba/ui/pages/register/register_page.dart';

import 'widgets/text_field_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late LoginUseCase loginUseCase;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    loginUseCase = LoginUseCase(AuthRepositoryImpl(AuthServiceImpl()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 200,
              ),
              const SizedBox(
                  height: 30), // Espacio entre el logo y el contenedor
              TextFieldContainer(
                // Usa el widget TextFieldContainer
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: const TextStyle(
                        fontWeight: FontWeight
                            .bold, // Establece el peso de la fuente en negrita
                      ),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Admin',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: UnderlineInputBorder(
                          // Cambia el color de la línea debajo del texto
                          borderSide: BorderSide(
                              color: Colors.grey), // Especifica el color blanco
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      style: const TextStyle(
                        fontWeight: FontWeight
                            .bold, // Establece el peso de la fuente en negrita
                      ),
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          // Cambia el color de la línea debajo del texto
                          borderSide: BorderSide(
                              color: Colors.grey), // Especifica el color blanco
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }, // Función para alternar visibilidad de la contraseña
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: const Color(0xFF18B9C3),
                ),
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  final result = await loginUseCase.login(username, password);
                  print(result);
                  if (result != 200) {
                    _showLoginFailedAlert(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LayoutPage()));
                  }
                },
              ),
              SizedBox(height: 10), // Espacio entre el botón de inicio de sesión y el botón de registro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  '¿No tienes una cuenta? Regístrate aquí',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLoginFailedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: Text('Incorrect username or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
