import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// API Service for Laravel backend integration
class ApiService {

  // IMPORTANT: Using HOSTED backend (not localhost)
  static const String baseUrl = 'http://13.232.1.72/api';
    static const String _tokenKey = 'auth_token';
    static const String _contentType = 'application/json';

    String? _authToken;

    // Singleton pattern
    static final ApiService _instance = ApiService._internal();
    factory ApiService() => _instance;
    ApiService._internal();

    // Initialize service
    Future<void> init() async {
      await _loadToken();
    }

    // Load token from shared preferences
    Future<void> _loadToken() async {
      final prefs = await SharedPreferences.getInstance();
      _authToken = prefs.getString(_tokenKey);
    }

    // Save token to shared preferences
    Future<void> _saveToken(String token) async {
      _authToken = token;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    }

    // Clear token
    Future<void> _clearToken() async {
      _authToken = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    }

    // Check if user is authenticated
    bool get isAuthenticated => _authToken != null;

    // Get headers (with or without auth)
    Map<String, String> _getHeaders({bool authenticated = false}) {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      if (authenticated && _authToken != null) {
        headers['Authorization'] = 'Bearer $_authToken';
      }

      return headers;
    }

    // Test connectivity to backend
    Future<bool> pingBackend() async {
      try {
        final response = await http.get(Uri.parse('$baseUrl/ping'));
        return response.statusCode == 200;
      } catch (e) {
        print('Backend ping failed: $e');
        return false;
      }
    }

    // Handle API response with proper error handling
    Map<String, dynamic> _handleResponse(http.Response response) {
      try {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (response.body.isEmpty) {
            return {'success': true};
          }
          return jsonDecode(response.body);
        } else if (response.statusCode == 401) {
          _clearToken();
          return {'success': false, 'message': 'Session expired. Please login again.'};
        } else {
          final errorData = jsonDecode(response.body);
          return {
            'success': false,
            'message': errorData['message'] ?? 'Request failed'
          };
        }
      } catch (e) {
        return {'success': false, 'message': 'Connection error: $e'};
      }
    }

    // ============================================================================
    // AUTH METHODS - Matching Laravel API exactly
    // ============================================================================

    /// Register - Create new user account
    Future<Map<String, dynamic>> register(String name, String email, String password) async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/register'),
          headers: _getHeaders(),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }),
        );

        final data = _handleResponse(response);

        // Save token and user data if successful
        if (data['success'] == true && data['data'] != null) {
          final token = data['data']['token'];
          await _saveToken(token);

          // Save user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', data['data']['user']['id'].toString());
          await prefs.setString('user_name', data['data']['user']['name']);
          await prefs.setString('user_email', data['data']['user']['email']);
          await prefs.setString('user_type', data['data']['user']['user_type'] ?? 'customer');
        }

        return data;
      } catch (e) {
        return {'success': false, 'message': 'Connection error: $e'};
      }
    }

    /// Login - Authenticate user and save token
    Future<Map<String, dynamic>> login(String email, String password) async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/login'),
          headers: _getHeaders(),
          body: jsonEncode({
            'email': email,
            'password': password,
            'device_name': 'Flutter App',
          }),
        );

        final data = _handleResponse(response);

        // Save token and user data if successful
        if (data['success'] == true && data['data'] != null) {
          final token = data['data']['token'];
          await _saveToken(token);

          // Save user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', data['data']['user']['id'].toString());
          await prefs.setString('user_name', data['data']['user']['name']);
          await prefs.setString('user_email', data['data']['user']['email']);
          await prefs.setString('user_type', data['data']['user']['user_type'] ?? 'customer');
        }

        return data;
      } catch (e) {
        return {'success': false, 'message': 'Connection error: $e'};
      }
    }

    /// Get User Profile - Uses /api/user endpoint
    Future<Map<String, dynamic>> getUserProfile() async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/user'),
          headers: _getHeaders(authenticated: true),
        );

        if (response.statusCode == 200) {
          return jsonDecode(response.body);  // Direct user object
        }

        return _handleResponse(response);
      } catch (e) {
        return {'success': false, 'message': 'Connection error: $e'};
      }
    }

    /// Logout - Clear session and token
    Future<Map<String, dynamic>> logout() async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: _getHeaders(authenticated: true),
        );

        // Clear all stored data
        await _clearToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('user_id');
        await prefs.remove('user_name');
        await prefs.remove('user_email');
        await prefs.remove('user_type');

        return _handleResponse(response);
      } catch (e) {
        // Clear local data even if server call fails
        await _clearToken();
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('user_id');
        await prefs.remove('user_name');
        await prefs.remove('user_email');
        await prefs.remove('user_type');

        return {'success': true, 'message': 'Logged out locally'};
      }
    }

    // ============================================================================
    // PRODUCT METHODS - Matching Laravel API exactly
    // ============================================================================

    /// Get Products - Returns list with pagination
    Future<Map<String, dynamic>> getProducts({int limit = 20, int page = 1}) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/products?limit=$limit&page=$page'),
          headers: _getHeaders(),
        );

        return _handleResponse(response);
      } catch (e) {
        return {
          'success': false,
          'message': 'Connection error: $e',
          'data': [],
        };
      }
    }

    /// Get Single Product by ID
    Future<Map<String, dynamic>> getProduct(int id) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/products/$id'),
          headers: _getHeaders(),
        );

        final data = _handleResponse(response);

        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }

        return {};
      } catch (e) {
        return {};
      }
    }

    /// Search Products
    Future<Map<String, dynamic>> searchProducts(String query) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/products/search?query=$query'),
          headers: _getHeaders(),
        );

        return _handleResponse(response);
      } catch (e) {
        return {
          'success': false,
          'message': 'Connection error: $e',
          'data': [],
        };
      }
    }

    // ============================================================================
    // ORDER METHODS - Matching Laravel API exactly
    // ============================================================================

    /// Get User Orders
    Future<Map<String, dynamic>> getOrders() async {
      try{
        final response = await http.get(
          Uri.parse('$baseUrl/orders'),
          headers: _getHeaders(authenticated: true),
        );

        return _handleResponse(response);
      } catch (e) {
        return {
          'success': false,
          'message': 'Connection error: $e',
          'data': [],
        };
      }
    }

    /// Get Single Order by ID
    Future<Map<String, dynamic>> getOrder(int id) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/orders/$id'),
          headers: _getHeaders(authenticated: true),
        );

        final data = _handleResponse(response);

        if (data['success'] == true) {
          return data['data'] ?? {};
        }

        return {};
      } catch (e) {
        return {};
      }
    }

    /// Place Order with cart items
    Future<Map<String, dynamic>> placeOrder({
      required List<Map<String, dynamic>> cartItems,
      String? firstName,
      String? lastName,
      String? address,
      String? city,
      String? state,
      String? zipCode,
      String? country,
      String? phone,
      String? paymentMethod,
      String? deliveryMethod,
    }) async {
      try {
        // Get user info from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final userName = prefs.getString('user_name') ?? 'Guest User';
        final userEmail = prefs.getString('user_email') ?? 'customer@example.com';
        final userPhone = phone ?? prefs.getString('user_phone') ?? '0000000000';
        final userAddress = address ?? prefs.getString('user_address') ?? 'Address not provided';
        
        // Split name into first and last name
        final nameParts = userName.trim().split(' ');
        final userFirstName = firstName ?? (nameParts.isNotEmpty ? nameParts[0] : 'Customer');
        final userLastName = lastName ?? (nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User');
        
        final orderData = {
          'cart_items': cartItems,
          'first_name': userFirstName,
          'last_name': userLastName,
          'email': userEmail,
          'address': userAddress,
          'city': city ?? 'Default City',
          'state': state ?? 'State',
          'zip': zipCode ?? '00000',
          'country': country ?? 'Country',
          'phone': userPhone,
          'payment_method': paymentMethod ?? 'credit_card',
          'delivery_method': deliveryMethod ?? 'home_delivery',
        };
        
        final response = await http.post(
          Uri.parse('$baseUrl/orders'),
          headers: _getHeaders(authenticated: true),
          body: jsonEncode(orderData),
        );

        return _handleResponse(response);
      } catch (e) {
        return {
          'success': false,
          'message': 'Connection error: $e'
        };
      }
    }

    /// Cancel Order
    Future<Map<String, dynamic>> cancelOrder(int orderId) async {
      try {
        final response = await http.delete(
          Uri.parse('$baseUrl/orders/$orderId'),
          headers: _getHeaders(authenticated: true),
        );

        return _handleResponse(response);
      } catch (e) {
        return {
          'success': false,
          'message': 'Connection error: $e'
        };
      }
    }
  }