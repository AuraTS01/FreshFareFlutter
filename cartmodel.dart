
class Product {
  final String name;
  final double baseprice;
  final String image;
  int quantity;
  String weight;

  Product({
    required this.name,
    required this.baseprice,
    required this.image,
    this.quantity = 1,
    this.weight = "1kg", 
  });

  double get price {
    if (weight == "0.5kg") {
      return baseprice / 2;
    }
    return baseprice;
  }
}


class Cart{
  List<Product> items = [];
  void addProduct(Product product){
    final index = items.indexWhere((item) => item.name == product.name);
    if(index >= 0){
      items[index].quantity++;
    }
    else{
      items.add(product);
    }
  }

  void removeProduct(Product product){
    items.removeWhere((item) => item.name == product.name);
  }

  double get totalPrice{
    return items.fold(0, (sum,item) => sum + (item.price * item.quantity));
  }

}
