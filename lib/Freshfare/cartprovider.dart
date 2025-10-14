import 'package:flutter/foundation.dart';
import 'package:freshfare/freshfare/cartmodel.dart';

class CartProvider extends ChangeNotifier {
 
  final Map<String, Cart> _shopCarts = {};

  String? _currentShopId;

 
  void setCurrentShop(String shopId) {
    _currentShopId = shopId;
    _shopCarts.putIfAbsent(shopId, () => Cart());
    notifyListeners();
  }


  String? get currentShopId => _currentShopId;

 
  List<Product> get items {
    if (_currentShopId == null) return [];
    return _shopCarts[_currentShopId]?.items ?? [];
  }

  double get totalPrice {
    if (_currentShopId == null) return 0.0;
    return _shopCarts[_currentShopId]?.totalPrice ?? 0.0;
  }

  void addProduct(Product product, String shopId) {
    setCurrentShop(shopId);
    final cart = _shopCarts[shopId]!;

    var index = cart.items.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      cart.items[index].quantity += 1;
    } else {
      cart.items.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (_currentShopId == null) return;
    final cart = _shopCarts[_currentShopId];
    cart?.removeProduct(product);
    notifyListeners();
  }

  void increaseQuantity(Product item) {
    if (_currentShopId == null) return;
    final cart = _shopCarts[_currentShopId];
    var index = cart?.items.indexWhere((i) => i.name == item.name) ?? -1;
    if (index >= 0) {
      cart!.items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product item) {
    if (_currentShopId == null) return;
    final cart = _shopCarts[_currentShopId];
    var index = cart?.items.indexWhere((i) => i.name == item.name) ?? -1;
    if (index == -1) return;

    if (cart!.items[index].quantity > 1) {
      cart.items[index].quantity--;
    } else {
      cart.items.removeAt(index);
    }
    notifyListeners();
  }

  bool isInCart(Product product) {
    if (_currentShopId == null) return false;
    return _shopCarts[_currentShopId]?.items
            .any((item) => item.name == product.name) ??
        false;
  }


  Cart? getCartForShop(String shopId) => _shopCarts[shopId];
}
