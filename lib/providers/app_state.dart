import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user.dart';
import '../models/perfume.dart';
import '../models/cart_item.dart';
import '../models/wishlist_item.dart';
import '../services/auth_service.dart';

/// Central app state management using Provider
/// Manages: User login state, Shopping cart, and Wishlist with local storage
class AppState with ChangeNotifier {
  final SharedPreferences _prefs;
  final AuthService _authService = AuthService();

  // User Authentication State
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Shopping Cart State
  final List<CartItem> _cartItems = [];

  // Wishlist State
  final List<WishlistItem> _wishlistItems = [];

  // Theme State
  bool _isDarkTheme = false;

  // Sensor Data State
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;
  double _gyroscopeX = 0.0;
  double _gyroscopeY = 0.0;
  double _gyroscopeZ = 0.0;
  int _batteryLevel = 100;
  bool _isCharging = false;

  // Constructor
  AppState(this._prefs) {
    _loadUserFromStorage();
    _loadCartFromStorage();
    _loadWishlistFromStorage();
  }

  // ============================================================================
  // GETTERS
  // ============================================================================

  // Authentication Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  // Cart Getters
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  int get cartItemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotalAmount => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Wishlist Getters
  List<WishlistItem> get wishlistItems => List.unmodifiable(_wishlistItems);
  int get wishlistItemCount => _wishlistItems.length;

  // Theme Getters
  bool get isDarkTheme => _isDarkTheme;

  // Sensor Data Getters
  double get accelerometerX => _accelerometerX;
  double get accelerometerY => _accelerometerY;
  double get accelerometerZ => _accelerometerZ;
  double get gyroscopeX => _gyroscopeX;
  double get gyroscopeY => _gyroscopeY;
  double get gyroscopeZ => _gyroscopeZ;
  int get batteryLevel => _batteryLevel;
  bool get isCharging => _isCharging;

  // ============================================================================
  // AUTHENTICATION METHODS
  // ============================================================================

  /// Login user with email and password
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _user = user;
        await _saveUserToStorage(user);
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

  /// Register new user
  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.register(name, email, password);
      if (user != null) {
        _user = user;
        await _saveUserToStorage(user);
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

  /// Logout user and clear all data
  Future<void> logout() async {
    _user = null;
    _cartItems.clear();
    _wishlistItems.clear();
    
    await _prefs.remove('user');
    await _prefs.remove('cart_items');
    await _prefs.remove('wishlist_items');
    
    notifyListeners();
  }

  /// Update user profile
  Future<void> updateProfile(User updatedUser) async {
    _setLoading(true);
    
    try {
      final user = await _authService.updateProfile(updatedUser);
      if (user != null) {
        _user = user;
        await _saveUserToStorage(user);
      }
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
    }
    
    _setLoading(false);
  }

  // ============================================================================
  // SHOPPING CART METHODS
  // ============================================================================

  /// Add perfume to cart
  void addToCart(Perfume perfume, {int quantity = 1}) {
    final existingIndex = _cartItems.indexWhere((item) => item.perfume.id == perfume.id);
    
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        perfume: perfume,
        quantity: quantity,
        addedAt: DateTime.now(),
      ));
    }
    
    _saveCartToStorage();
    notifyListeners();
  }

  /// Remove perfume from cart
  void removeFromCart(String perfumeId) {
    _cartItems.removeWhere((item) => item.perfume.id == perfumeId);
    _saveCartToStorage();
    notifyListeners();
  }

  /// Update cart item quantity
  void updateCartQuantity(String perfumeId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(perfumeId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.perfume.id == perfumeId);
    if (index >= 0) {
      _cartItems[index].quantity = newQuantity;
      _saveCartToStorage();
      notifyListeners();
    }
  }

  /// Clear entire cart
  void clearCart() {
    _cartItems.clear();
    _saveCartToStorage();
    notifyListeners();
  }

  /// Check if perfume is in cart
  bool isInCart(String perfumeId) {
    return _cartItems.any((item) => item.perfume.id == perfumeId);
  }

  /// Get quantity of perfume in cart
  int getCartQuantity(String perfumeId) {
    final item = _cartItems.firstWhere(
      (item) => item.perfume.id == perfumeId,
      orElse: () => CartItem(
        id: '',
        perfume: Perfume(
          id: '',
          name: '',
          brand: '',
          description: '',
          price: 0,
          imageUrl: '',
          notes: [],
          category: '',
        ),
        addedAt: DateTime.now(),
      ),
    );
    return item.id.isEmpty ? 0 : item.quantity;
  }

  // ============================================================================
  // WISHLIST METHODS
  // ============================================================================

  /// Add perfume to wishlist
  void addToWishlist(Perfume perfume) {
    if (!isInWishlist(perfume.id)) {
      _wishlistItems.add(WishlistItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        perfume: perfume,
        addedAt: DateTime.now(),
      ));
      
      _saveWishlistToStorage();
      notifyListeners();
    }
  }

  /// Remove perfume from wishlist
  void removeFromWishlist(String perfumeId) {
    _wishlistItems.removeWhere((item) => item.perfume.id == perfumeId);
    _saveWishlistToStorage();
    notifyListeners();
  }

  /// Toggle perfume in wishlist
  void toggleWishlist(Perfume perfume) {
    if (isInWishlist(perfume.id)) {
      removeFromWishlist(perfume.id);
    } else {
      addToWishlist(perfume);
    }
  }

  /// Clear entire wishlist
  void clearWishlist() {
    _wishlistItems.clear();
    _saveWishlistToStorage();
    notifyListeners();
  }

  /// Check if perfume is in wishlist
  bool isInWishlist(String perfumeId) {
    return _wishlistItems.any((item) => item.perfume.id == perfumeId);
  }

  /// Move item from wishlist to cart
  void moveFromWishlistToCart(String perfumeId) {
    final wishlistItem = _wishlistItems.firstWhere(
      (item) => item.perfume.id == perfumeId,
    );
    
    addToCart(wishlistItem.perfume);
    removeFromWishlist(perfumeId);
  }

  // ============================================================================
  // LOCAL STORAGE METHODS
  // ============================================================================

  /// Load user data from SharedPreferences
  void _loadUserFromStorage() {
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

  /// Save user data to SharedPreferences
  Future<void> _saveUserToStorage(User user) async {
    final userJson = json.encode(user.toJson());
    await _prefs.setString('user', userJson);
  }

  /// Load cart data from SharedPreferences
  void _loadCartFromStorage() {
    final cartJson = _prefs.getString('cart_items');
    if (cartJson != null) {
      try {
        final List<dynamic> cartList = json.decode(cartJson);
        _cartItems.clear();
        _cartItems.addAll(
          cartList.map((item) => CartItem.fromJson(item)).toList(),
        );
        notifyListeners();
      } catch (e) {
        _prefs.remove('cart_items');
      }
    }
  }

  /// Save cart data to SharedPreferences
  Future<void> _saveCartToStorage() async {
    final cartJson = json.encode(
      _cartItems.map((item) => item.toJson()).toList(),
    );
    await _prefs.setString('cart_items', cartJson);
  }

  /// Load wishlist data from SharedPreferences
  void _loadWishlistFromStorage() {
    final wishlistJson = _prefs.getString('wishlist_items');
    if (wishlistJson != null) {
      try {
        final List<dynamic> wishlistList = json.decode(wishlistJson);
        _wishlistItems.clear();
        _wishlistItems.addAll(
          wishlistList.map((item) => WishlistItem.fromJson(item)).toList(),
        );
        notifyListeners();
      } catch (e) {
        _prefs.remove('wishlist_items');
      }
    }
  }

  /// Save wishlist data to SharedPreferences
  Future<void> _saveWishlistToStorage() async {
    final wishlistJson = json.encode(
      _wishlistItems.map((item) => item.toJson()).toList(),
    );
    await _prefs.setString('wishlist_items', wishlistJson);
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Clear error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear error message (public method)
  void clearError() {
    _clearError();
  }

  // ============================================================================
  // THEME METHODS
  // ============================================================================

  /// Toggle theme between light and dark
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  /// Set theme to dark or light
  void setTheme(bool isDark) {
    _isDarkTheme = isDark;
    notifyListeners();
  }

  // ============================================================================
  // SENSOR DATA METHODS
  // ============================================================================

  /// Update accelerometer data
  void updateAccelerometer(double x, double y, double z) {
    _accelerometerX = x;
    _accelerometerY = y;
    _accelerometerZ = z;
    notifyListeners();
  }

  /// Update gyroscope data
  void updateGyroscope(double x, double y, double z) {
    _gyroscopeX = x;
    _gyroscopeY = y;
    _gyroscopeZ = z;
    notifyListeners();
  }

  /// Update battery level
  void updateBatteryLevel(int level) {
    _batteryLevel = level;
    notifyListeners();
  }

  /// Update charging status
  void updateChargingStatus(bool isCharging) {
    _isCharging = isCharging;
    notifyListeners();
  }

  // ============================================================================
  // ANALYTICS & UTILITY METHODS
  // ============================================================================

  /// Get cart summary for checkout
  Map<String, dynamic> getCartSummary() {
    return {
      'itemCount': cartItemCount,
      'totalAmount': cartTotalAmount,
      'items': _cartItems.map((item) => {
        'name': item.perfume.name,
        'brand': item.perfume.brand,
        'quantity': item.quantity,
        'price': item.perfume.price,
        'total': item.totalPrice,
      }).toList(),
    };
  }

  /// Get wishlist summary
  Map<String, dynamic> getWishlistSummary() {
    return {
      'itemCount': wishlistItemCount,
      'totalValue': _wishlistItems.fold(0.0, (sum, item) => sum + item.perfume.price),
      'items': _wishlistItems.map((item) => {
        'name': item.perfume.name,
        'brand': item.perfume.brand,
        'price': item.perfume.price,
        'addedAt': item.addedAt.toIso8601String(),
      }).toList(),
    };
  }

  /// Search cart items
  List<CartItem> searchCartItems(String query) {
    if (query.isEmpty) return _cartItems;
    
    return _cartItems.where((item) {
      return item.perfume.name.toLowerCase().contains(query.toLowerCase()) ||
             item.perfume.brand.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  /// Search wishlist items
  List<WishlistItem> searchWishlistItems(String query) {
    if (query.isEmpty) return _wishlistItems;
    
    return _wishlistItems.where((item) {
      return item.perfume.name.toLowerCase().contains(query.toLowerCase()) ||
             item.perfume.brand.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  /// Get recently added wishlist items
  List<WishlistItem> getRecentWishlistItems({int limit = 5}) {
    final sortedItems = List<WishlistItem>.from(_wishlistItems);
    sortedItems.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return sortedItems.take(limit).toList();
  }

  /// Get cart items by category
  List<CartItem> getCartItemsByCategory(String category) {
    return _cartItems.where((item) => 
      item.perfume.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  /// Get wishlist items by category
  List<WishlistItem> getWishlistItemsByCategory(String category) {
    return _wishlistItems.where((item) => 
      item.perfume.category.toLowerCase() == category.toLowerCase()
    ).toList();
  }
}