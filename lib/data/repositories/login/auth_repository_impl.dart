//auth_repository_impl.dart
import 'package:prueba/data/services/login/auth_service_impl.dart';
import 'package:prueba/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthServiceImpl authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<int?> login(String email, String password) async {
    final responseCode = await authService.login(email, password);
    return responseCode;
  }

  @override
  Future<int?> register(String email, String password) async {
    final responseCode = await authService.register(email, password);
    return responseCode;
  }
}
