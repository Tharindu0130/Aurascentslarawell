import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/perfume.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addToCart(Perfume perfume, {int quantity = 1}) {
    final existingIndex = _items.indexWhere((item) => item.perfume.id == perfume.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        perfume: perfume,
        quantity: quantity,
        addedAt: DateTime.now(),
      ));
    }
    
    notifyListeners();
  }

  void removeFromCart(String perfumeId) {
    _items.removeWhere((item) => item.perfume.id == perfumeId);
    notifyListeners();
  }

  void updateQuantity(String perfumeId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(perfumeId);
      return;
    }

    final index = _items.indexWhere((item) => item.perfume.id == perfumeId);
    if (index >= 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String perfumeId) {
    return _items.any((item) => item.perfume.id == perfumeId);
  }

  int getQuantity(String perfumeId) {
    final item = _items.firstWhere(
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
}