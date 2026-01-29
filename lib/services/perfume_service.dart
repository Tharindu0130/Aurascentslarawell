import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/perfume.dart';
import 'api_service.dart';

/// PerfumeService - Handles fetching perfumes from Laravel backend with offline fallback
class PerfumeService {
  final ApiService _apiService = ApiService();
  List<Perfume>? _cachedPerfumes;

  /// Get all perfumes from backend API (with offline JSON fallback)
  Future<List<Perfume>> getAllPerfumes() async {
    try {
      // Try to fetch from API first
      final response = await _apiService.getProducts(limit: 50);
      
      if (response['success'] == true && response['data'] != null) {
        List<dynamic> productsData = response['data'];
        
        // Convert Laravel products to Flutter Perfume models
        List<Perfume> perfumes = productsData.map((product) {
          return Perfume(
            id: product['id'].toString(),
            name: product['name'] ?? 'Unknown Product',
            brand: product['user']?['name'] ?? 'Aura Scents',  // Use seller name as brand
            description: product['description'] ?? 'No description available',
            price: double.parse(product['price'].toString()),
            imageUrl: product['image'] ?? 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
            notes: [], // Laravel doesn't have notes field
            category: product['category']?['name'] ?? 'Unisex',
            rating: 4.5, // Default rating
            reviewCount: 0, // Default review count
            stockQuantity: product['stock'] ?? 0,
          );
        }).toList();
        
        // Cache for offline use
        _cachedPerfumes = perfumes;
        
        return perfumes;
      }
      
      throw Exception('API returned unsuccessful response');
    } catch (e) {
      print('Failed to load from API: $e');
      
      // Fallback to local JSON file
      return await _loadFromLocalJson();
    }
  }

  /// Load perfumes from local JSON file (offline fallback)
  Future<List<Perfume>> _loadFromLocalJson() async {
    try {
      // Try to return cached data first
      if (_cachedPerfumes != null && _cachedPerfumes!.isNotEmpty) {
        return _cachedPerfumes!;
      }
      
      // Load from assets
      String jsonString = await rootBundle.loadString('assets/data/perfumes.json');
      List<dynamic> jsonData = json.decode(jsonString);
      
      List<Perfume> perfumes = jsonData.map((item) => Perfume.fromJson(item)).toList();
      
      _cachedPerfumes = perfumes;
      return perfumes;
    } catch (e) {
      throw Exception('Failed to load perfumes from local storage: ${e.toString()}');
    }
  }

  /// Get single perfume by ID
  Future<Perfume?> getPerfumeById(String id) async {
    try {
      // Try to fetch from API first
      final productData = await _apiService.getProduct(int.parse(id));
      
      // Convert to Perfume model
      return Perfume(
        id: productData['id'].toString(),
        name: productData['name'] ?? 'Unknown Product',
        brand: productData['user']?['name'] ?? 'Aura Scents',
        description: productData['description'] ?? 'No description available',
        price: double.parse(productData['price'].toString()),
        imageUrl: productData['image'] ?? 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
        notes: [],
        category: productData['category']?['name'] ?? 'Unisex',
        rating: 4.5,
        reviewCount: 0,
        stockQuantity: productData['stock'] ?? 0,
      );
    } catch (e) {
      print('Failed to load perfume from API: $e');
      
      // Fallback to cached or local data
      final perfumes = await getAllPerfumes();
      for (var perfume in perfumes) {
        if (perfume.id == id) {
          return perfume;
        }
      }
      return null;
    }
  }

  /// Search perfumes
  Future<List<Perfume>> searchPerfumes(String query) async {
    try {
      final response = await _apiService.searchProducts(query);
      
      if (response['success'] == true && response['data'] != null) {
        List<dynamic> productsData = response['data'];
        
        return productsData.map((product) {
          return Perfume(
            id: product['id'].toString(),
            name: product['name'] ?? 'Unknown Product',
            brand: product['user']?['name'] ?? 'Aura Scents',
            description: product['description'] ?? '',
            price: double.parse(product['price'].toString()),
            imageUrl: product['image'] ?? 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
            notes: [],
            category: 'Unisex',
            rating: 4.5,
            reviewCount: 0,
            stockQuantity: product['stock'] ?? 0,
          );
        }).toList();
      }
      
      return [];
    } catch (e) {
      print('Search failed: $e');
      // Fallback to local search
      final allPerfumes = await getAllPerfumes();
      return allPerfumes.where((p) => 
        p.name.toLowerCase().contains(query.toLowerCase()) ||
        p.brand.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  }
}