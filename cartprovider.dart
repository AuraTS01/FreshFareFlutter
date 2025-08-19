import 'package:flutter/foundation.dart';
import 'package:freshfare/freshfare/cartmodel.dart';

class CartProvider extends ChangeNotifier{
  final Cart cart = Cart();

  List<Product> get items => cart.items;
  double get totalPrice => cart.totalPrice;

  void addProduct(Product product){
    cart.addProduct(product);
    notifyListeners();
  }
  void removeProduct(Product product){
    cart.removeProduct(product);
    notifyListeners();
  }

} 