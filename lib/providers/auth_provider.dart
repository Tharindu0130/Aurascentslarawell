import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  final AuthService _authService = AuthService();
  
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._prefs) {
    _loadUserFromPrefs();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  void _loadUserFromPrefs() {
    final userJson = _prefs.getString('user');
    if (userJson != null) {
      try {
        final userMap = json.decode(userJson);
        _user = User.fromJson(userMap);
        notifyListeners();
      } catch (e) {
        _prefs.remove('user');
      }
    }
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _user = user;
        await _saveUserToPrefs(user);
        _setLoading(false);
        return true;
      } else {
        _setError('Invalid email or password');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Login failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.register(name, email, password);
      if (user != null) {
        _user = user;
        await _saveUserToPrefs(user);
        _setLoading(false);
        return true;
      } else {
        _setError('Registration failed');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Registration failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    await _prefs.remove('user');
    notifyListeners();
  }

  Future<void> updateProfile(User updatedUser) async {
    _setLoading(true);
    
    try {
      final user = await _authService.updateProfile(updatedUser);
      if (user != null) {
        _user = user;
        await _saveUserToPrefs(user);
      }
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
    }
    
    _setLoading(false);
  }

  Future<void> _saveUserToPrefs(User user) async {
    final userJson = json.encode(user.toJson());
    await _prefs.setString('user', userJson);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}