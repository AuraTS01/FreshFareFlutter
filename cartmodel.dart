class Product{
  final String name;
  final double price;
  final String image;
  int quantity;

  Product({required this.name, required this.price, required this.image ,this.quantity = 1});
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