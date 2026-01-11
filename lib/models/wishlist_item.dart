import 'perfume.dart';

class WishlistItem {
  final String id;
  final Perfume perfume;
  final DateTime addedAt;

  WishlistItem({
    required this.id,
    required this.perfume,
    required this.addedAt,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'] ?? '',
      perfume: Perfume.fromJson(json['perfume'] ?? {}),
      addedAt: DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'perfume': perfume.toJson(),
      'addedAt': addedAt.toIso8601String(),
    };
  }

  WishlistItem copyWith({
    String? id,
    Perfume? perfume,
    DateTime? addedAt,
  }) {
    return WishlistItem(
      id: id ?? this.id,
      perfume: perfume ?? this.perfume,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}