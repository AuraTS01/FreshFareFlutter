import 'package:flutter/foundation.dart';
import 'package:freshfare/freshfare/cartmodel.dart';

class CartProvider extends ChangeNotifier{
  final Cart cart = Cart();

  List<Product> get items => cart.items;
  double get totalPrice => cart.totalPrice;

  void addProduct(Product product){
    var index = items.indexWhere((item) => item.name == product.name);
    if(index != -1){
      items[index].quantity += 1;
    }
    else{
      items.add(Product(
        name:product.name,
        baseprice:product.price,
        image:product.image,
      ));
    }
    notifyListeners();
  }
  void removeProduct(Product product){
    cart.removeProduct(product);
    notifyListeners();
  }

  void increaseQuantity(Product item){
    var index = items.indexWhere((i) => i.name == item.name);
    if(index >= 0){
    items[index].quantity++;
    }
    notifyListeners();
  }

  void decreaseQuantity(Product item){
    var index = items.indexWhere((i) => i.name == item.name);
    if(index == -1) return;

    if(items[index].quantity > 1){
      items[index].quantity--;
    }else{
      items.remove(index);
    }
    notifyListeners();
  }

   bool isInCart(Product product) {
    return items.any((item) => item.name == product.name);
  }

}
