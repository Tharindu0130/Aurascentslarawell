import 'perfume.dart';

class CartItem {
  final String id;
  final Perfume perfume;
  int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.perfume,
    this.quantity = 1,
    required this.addedAt,
  });

  double get totalPrice => perfume.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      perfume: Perfume.fromJson(json['perfume'] ?? {}),
      quantity: json['quantity'] ?? 1,
      addedAt: DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'perfume': perfume.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  CartItem copyWith({
    String? id,
    Perfume? perfume,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      perfume: perfume ?? this.perfume,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}