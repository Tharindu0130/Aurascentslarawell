import '../models/user.dart';
import 'api_service.dart';

/// AuthService - Handles authentication using the Laravel backend API
class AuthService {
  final ApiService _apiService = ApiService();
  
  /// Login user with email and password
  Future<User?> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      
      // Check if login was successful
      if (response['success'] == true && response['data'] != null) {
        final userData = response['data']['user'];
        
        // Convert Laravel user to Flutter User model
        return User(
          id: userData['id'].toString(),
          email: userData['email'],
          name: userData['name'],
          profileImageUrl: userData['profile_photo_url'],
          createdAt: DateTime.parse(userData['created_at'] ?? DateTime.now().toIso8601String()),
          lastLoginAt: DateTime.now(),
        );
      }
      
      return null;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  /// Register new user (if backend supports registration)
  Future<User?> register(String name, String email, String password) async {
    try {
      // Note: You might need to add a register endpoint to your Laravel API
      // For now, returning a mock user or throwing an exception
      throw Exception('Registration not implemented in backend API yet');
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  /// Update user profile
  Future<User?> updateProfile(User user) async {
    try {
      // Get current profile from backend
      final profileData = await _apiService.getUserProfile();
      
      // Convert to User model
      return User(
        id: profileData['id'].toString(),
        email: profileData['email'],
        name: profileData['name'],
        profileImageUrl: profileData['profile_photo_url'],
        phoneNumber: user.phoneNumber, // Keep local phone number
        address: user.address, // Keep local address
        createdAt: DateTime.parse(profileData['created_at']),
        lastLoginAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    }
  }
  
  /// Get current user profile
  Future<User?> getCurrentUser() async {
    try {
      final profileData = await _apiService.getUserProfile();
      
      return User(
        id: profileData['id'].toString(),
        email: profileData['email'],
        name: profileData['name'],
        profileImageUrl: profileData['profile_photo_url'],
        createdAt: DateTime.parse(profileData['created_at']),
        lastLoginAt: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
}