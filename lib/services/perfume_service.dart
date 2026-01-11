import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/perfume.dart';

class PerfumeService {
  static const String baseUrl = 'https://api.perfumestore.com'; // Mock API URL

  Future<List<Perfume>> getAllPerfumes() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Return mock data - in real app, this would be an actual API call
      return _getMockPerfumes();
    } catch (e) {
      throw Exception('Failed to load perfumes: ${e.toString()}');
    }
  }

  Future<Perfume?> getPerfumeById(String id) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final perfumes = _getMockPerfumes();
      return perfumes.firstWhere((perfume) => perfume.id == id);
    } catch (e) {
      throw Exception('Failed to load perfume: ${e.toString()}');
    }
  }

  List<Perfume> _getMockPerfumes() {
    return [
      Perfume(
        id: '1',
        name: 'Midnight Elegance',
        brand: 'Luxe Fragrances',
        description: 'A sophisticated evening fragrance with deep, mysterious notes that captivate and enchant. Perfect for special occasions and romantic evenings.',
        price: 89.99,
        imageUrl: 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400',
        notes: ['Bergamot', 'Rose', 'Sandalwood', 'Vanilla'],
        category: 'Women',
        rating: 4.5,
        reviewCount: 127,
        stockQuantity: 25,
      ),
      Perfume(
        id: '2',
        name: 'Ocean Breeze',
        brand: 'Fresh Scents',
        description: 'A refreshing aquatic fragrance that brings the essence of the ocean to your daily routine. Light, airy, and perfect for summer days.',
        price: 65.50,
        imageUrl: 'https://images.unsplash.com/photo-1588405748880-12d1d2a59d75?w=400',
        notes: ['Sea Salt', 'Citrus', 'White Musk', 'Driftwood'],
        category: 'Unisex',
        rating: 4.2,
        reviewCount: 89,
        stockQuantity: 40,
      ),
      Perfume(
        id: '3',
        name: 'Royal Oud',
        brand: 'Arabian Nights',
        description: 'An opulent oriental fragrance featuring the finest oud wood. Rich, warm, and luxurious - a true statement of sophistication.',
        price: 150.00,
        imageUrl: 'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400',
        notes: ['Oud Wood', 'Saffron', 'Amber', 'Leather'],
        category: 'Men',
        rating: 4.8,
        reviewCount: 203,
        stockQuantity: 15,
      ),
      Perfume(
        id: '4',
        name: 'Garden Paradise',
        brand: 'Floral Dreams',
        description: 'A delightful floral bouquet that captures the essence of a blooming garden in spring. Fresh, feminine, and utterly charming.',
        price: 72.25,
        imageUrl: 'https://images.unsplash.com/photo-1563170351-be82bc888aa4?w=400',
        notes: ['Peony', 'Jasmine', 'Green Leaves', 'White Tea'],
        category: 'Women',
        rating: 4.3,
        reviewCount: 156,
        stockQuantity: 30,
      ),
      Perfume(
        id: '5',
        name: 'Urban Legend',
        brand: 'Modern Classics',
        description: 'A contemporary woody fragrance for the modern man. Bold, confident, and perfect for both day and night wear.',
        price: 95.75,
        imageUrl: 'https://images.unsplash.com/photo-1594736797933-d0401ba2fe65?w=400',
        notes: ['Cedar', 'Black Pepper', 'Vetiver', 'Tonka Bean'],
        category: 'Men',
        rating: 4.6,
        reviewCount: 178,
        stockQuantity: 22,
      ),
      Perfume(
        id: '6',
        name: 'Citrus Burst',
        brand: 'Fresh Scents',
        description: 'An energizing citrus fragrance that awakens your senses. Bright, zesty, and perfect for starting your day with enthusiasm.',
        price: 58.00,
        imageUrl: 'https://images.unsplash.com/photo-1615634260167-c8cdede054de?w=400',
        notes: ['Lemon', 'Grapefruit', 'Mint', 'Ginger'],
        category: 'Unisex',
        rating: 4.1,
        reviewCount: 94,
        stockQuantity: 35,
      ),
      Perfume(
        id: '7',
        name: 'Velvet Rose',
        brand: 'Romantic Collection',
        description: 'A luxurious rose fragrance with velvety smooth undertones. Romantic, elegant, and timelessly beautiful.',
        price: 110.50,
        imageUrl: 'https://images.unsplash.com/photo-1587017539504-67cfbddac569?w=400',
        notes: ['Bulgarian Rose', 'Peach', 'Musk', 'Patchouli'],
        category: 'Women',
        rating: 4.7,
        reviewCount: 245,
        stockQuantity: 18,
      ),
      Perfume(
        id: '8',
        name: 'Spice Market',
        brand: 'Oriental Treasures',
        description: 'An exotic spicy fragrance inspired by ancient spice markets. Warm, mysterious, and absolutely captivating.',
        price: 125.00,
        imageUrl: 'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400',
        notes: ['Cardamom', 'Cinnamon', 'Incense', 'Myrrh'],
        category: 'Unisex',
        rating: 4.4,
        reviewCount: 167,
        stockQuantity: 20,
      ),
    ];
  }
}