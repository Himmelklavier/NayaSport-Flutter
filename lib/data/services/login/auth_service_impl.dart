import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl implements AuthRepository {
  @override
  Future<int?> login(String email, String password) async {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    // Realiza la solicitud HTTP
    final response = await http.post(
      Uri.parse('http://192.168.1.11:3001/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    // Comprueba el código de estado de la respuesta
    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, decodifica la respuesta JSON
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final accessToken = responseData['accessToken']['accessToken'];
      final id = responseData['id'];
      final rol = responseData['rol'];

      // Guardar el accessToken en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      await prefs.setInt('idUsuario', id);
      await prefs.setInt('rol', rol);

      return response.statusCode;
    } else {
      // Si hay un error en la solicitud, lanza una excepción o maneja el error según tus necesidades
      //throw Exception('Failed to login: ${response.statusCode}');
      return response.statusCode;
    }
  }

  @override
  Future<int?> register(String email, String password) async {
    // Construye el cuerpo de la solicitud
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    // Realiza la solicitud HTTP
    final response = await http.post(
      Uri.parse('http://192.168.1.11:3001/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    // Comprueba el código de estado de la respuesta
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final accessToken = responseData['accessToken']['accessToken'];
      final id = responseData['id'];
      final rol = responseData['rol'];

      //Guardar el accessToken en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      await prefs.setInt('idUsuario', id);
      await prefs.setString('rol', rol);

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
