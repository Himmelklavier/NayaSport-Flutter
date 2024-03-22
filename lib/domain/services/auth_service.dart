abstract class AuthService {
  Future<int?> login(String email, String password);
  Future<int?> register(String email, String password);
}
