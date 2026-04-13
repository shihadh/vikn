import 'package:flutter/material.dart';
import '../service/profile_service.dart';
import '../model/profile_model.dart';
import '../../../core/utils/secure_storage_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _service = ProfileService();
  final SecureStorageService _storage = SecureStorageService();

  ProfileModel? _userData;
  ProfileModel? get userData => _userData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile() async {
    _isLoading = true;
    notifyListeners();

    final (data, error) = await _service.fetchProfile();

    if (error == null) {
      _userData = data;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await _storage.clearAuthData();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}
