import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'https://api.perfumestore.com'; // Mock API URL
  
  Future<User?> login(String email, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock authentication - in real app, this would be an actual API call
      if (email == 'user@perfumestore.com' && password == 'password123') {
        return User(
          id: '1',
          email: email,
          name: 'John Doe',
          phoneNumber: '+1234567890',
          address: '123 Perfume Street, Fragrance City',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          lastLoginAt: DateTime.now(),
        );
      }
      
      // Check for demo users
      final demoUsers = _getDemoUsers();
      for (final user in demoUsers) {
        if (user.email == email && password == 'demo123') {
          return user.copyWith(lastLoginAt: DateTime.now());
        }
      }
      
      return null;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<User?> register(String name, String email, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock registration - in real app, this would be an actual API call
      return User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<User?> updateProfile(User user) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock profile update - in real app, this would be an actual API call
      return user;
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }

  List<User> _getDemoUsers() {
    return [
      User(
        id: '2',
        email: 'alice@demo.com',
        name: 'Alice Johnson',
        phoneNumber: '+1987654321',
        address: '456 Scent Avenue, Aroma Town',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
      ),
      User(
        id: '3',
        email: 'bob@demo.com',
        name: 'Bob Smith',
        phoneNumber: '+1122334455',
        address: '789 Fragrance Boulevard, Perfume City',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
      ),
    ];
  }
}