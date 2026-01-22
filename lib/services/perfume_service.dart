
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/perfume.dart';

class PerfumeService {
  static const String baseUrl = 'https://api.perfumestore.com'; // Mock API URL
  
  List<Perfume>? _cachedPerfumes;

  Future<List<Perfume>> getAllPerfumes() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Load data from JSON asset file
      String jsonString = await rootBundle.loadString('assets/data/perfumes.json');
      List<dynamic> jsonData = json.decode(jsonString);
      
      List<Perfume> perfumes = jsonData.map((item) => Perfume.fromJson(item)).toList();
      
      // Cache the perfumes for potential offline use
      _cachedPerfumes = perfumes;
      
      return perfumes;
    } catch (e) {
      // If loading from assets fails, return cached data if available
      if (_cachedPerfumes != null && _cachedPerfumes!.isNotEmpty) {
        return _cachedPerfumes!;
      }
      throw Exception('Failed to load perfumes: ${e.toString()}');
    }
  }

  Future<Perfume?> getPerfumeById(String id) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final perfumes = await getAllPerfumes();
      for (var perfume in perfumes) {
        if (perfume.id == id) {
          return perfume;
        }
      }
      return null;
    } catch (e) {
      // Try to find in cached perfumes if available
      if (_cachedPerfumes != null) {
        for (var perfume in _cachedPerfumes!) {
          if (perfume.id == id) {
            return perfume;
          }
        }
      }
      throw Exception('Failed to load perfume: ${e.toString()}');
    }
  }


}