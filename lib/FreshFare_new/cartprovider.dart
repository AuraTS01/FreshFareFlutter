// FreshFare_New/cartprovider.dart
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  double quantity;
  final String companyName; // Company for grouping
  final String imagePath;   // Product image path

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.companyName = '',
    this.imagePath = '', // optional, default empty
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  // Total amount for all items
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Total per company
  double companyTotal(String companyName) {
    return _items
        .where((item) => item.companyName == companyName)
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(CartItem item) {
    // Use id as unique key
    final index = _items.indexWhere((existing) => existing.id == item.id);
    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void increaseQuantity(CartItem item, {double by = 1.0}) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity += by;
      notifyListeners();
    }
  }

  void decreaseQuantity(CartItem item, {double by = 1.0}) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity -= by;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
