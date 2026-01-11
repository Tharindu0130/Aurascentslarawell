class Perfume {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> notes;
  final String category;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final int stockQuantity;

  Perfume({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.notes,
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isAvailable = true,
    this.stockQuantity = 0,
  });

  factory Perfume.fromJson(Map<String, dynamic> json) {
    return Perfume(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      notes: List<String>.from(json['notes'] ?? []),
      category: json['category'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      stockQuantity: json['stockQuantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'notes': notes,
      'category': category,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
    };
  }

  Perfume copyWith({
    String? id,
    String? name,
    String? brand,
    String? description,
    double? price,
    String? imageUrl,
    List<String>? notes,
    String? category,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
    int? stockQuantity,
  }) {
    return Perfume(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      notes: notes ?? this.notes,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}