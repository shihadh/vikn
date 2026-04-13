import 'package:flutter/material.dart';
import '../service/login_service.dart';
import '../../../core/utils/secure_storage_service.dart';

class LoginController extends ChangeNotifier {
  final LoginService _service = LoginService();
  final SecureStorageService _storage = SecureStorageService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<String?> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return "Username and Password are required";
    }

    _isLoading = true;
    notifyListeners();

    final (data, error) = await _service.login(
      usernameController.text,
      passwordController.text,
    );

    if (error != null) {
      _isLoading = false;
      notifyListeners();
      return error;
    }

    if (data != null) {
      if (data.token.isNotEmpty && data.userId.isNotEmpty) {
        await _storage.saveToken(data.token);
        await _storage.saveUserId(data.userId);
        _isLoading = false;
        notifyListeners();
        return null; // Success
      }
    }

    _isLoading = false;
    notifyListeners();
    return "Invalid response from server";
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
