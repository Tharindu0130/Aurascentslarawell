
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/perfume.dart';

class PerfumeService {
  static const String baseUrl = 'https://api.perfumestore.com'; // Mock API URL

  Future<List<Perfume>> getAllPerfumes() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Load data from JSON asset file
      String jsonString = await rootBundle.loadString('assets/data/perfumes.json');
      List<dynamic> jsonData = json.decode(jsonString);
      
      List<Perfume> perfumes = jsonData.map((item) => Perfume.fromJson(item)).toList();
      
      return perfumes;
    } catch (e) {
      throw Exception('Failed to load perfumes: ${e.toString()}');
    }
  }

  Future<Perfume?> getPerfumeById(String id) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final perfumes = await getAllPerfumes();
      return perfumes.firstWhere((perfume) => perfume.id == id);
    } catch (e) {
      throw Exception('Failed to load perfume: ${e.toString()}');
    }
  }


}