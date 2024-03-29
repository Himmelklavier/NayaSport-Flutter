// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba/domain/usecases/login/login_use_case.dart';
import 'package:prueba/ui/layout/layout.dart';
import 'package:prueba/ui/pages/login/widgets/text_field_container.dart';

import '../../../data/repositories/login/auth_repository_impl.dart';
import '../../../data/services/login/auth_service_impl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late LoginUseCase loginUseCase;

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
                        labelText: 'Usuario',
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
                          onPressed:
                              () {}, // Función para alternar visibilidad de la contraseña
                          icon: const Icon(Icons.password),
                        ),
                      ),
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
                  'Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  final result =
                      await loginUseCase.register(username, password);
                  print('res1111: $result');
                  if (result == 201) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LayoutPage(index: 0)),
                    );
                  } else {
                    _showRegisterFailedAlert(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterFailedAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Failed'),
          content: const Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
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
