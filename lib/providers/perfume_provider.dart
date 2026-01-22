import 'package:flutter/material.dart';
import '../models/perfume.dart';
import '../services/data_service.dart';

class PerfumeProvider with ChangeNotifier {
  final DataService _dataService = DataService();
  
  List<Perfume> _perfumes = [];
  List<Perfume> _filteredPerfumes = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Perfume> get perfumes => _filteredPerfumes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  List<String> get categories => [
    'All',
    'Men',
    'Women',
    'Unisex',
    'Oriental',
    'Fresh',
    'Woody',
    'Floral'
  ];

  Future<void> loadPerfumes() async {
    _setLoading(true);
    _clearError();

    try {
      _perfumes = await _dataService.loadPerfumes();
      _applyFilters();
    } catch (e) {
      _setError('Failed to load perfumes: ${e.toString()}');
    }

    _setLoading(false);
  }

  void searchPerfumes(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredPerfumes = _perfumes.where((perfume) {
      final matchesSearch = _searchQuery.isEmpty ||
          perfume.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          perfume.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          perfume.description.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory = _selectedCategory == 'All' ||
          perfume.category.toLowerCase() == _selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  Future<Perfume?> getPerfumeById(String id) async {
    try {
      return await _dataService.getPerfumeById(id);
    } catch (e) {
      _setError('Failed to load perfume details: ${e.toString()}');
      return null;
    }
  }

  List<Perfume> getFeaturedPerfumes() {
    return _perfumes.where((perfume) => perfume.rating >= 4.0).take(5).toList();
  }

  List<Perfume> getPopularPerfumes() {
    return _perfumes.where((perfume) => perfume.reviewCount > 50).take(5).toList();
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