// FreshFare_New/cart.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freshfare/FreshFare_New/cartprovider.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Map<String, double> incrementValues = {};

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Group items by companyName
    Map<String, List<CartItem>> itemsByCompany = {};
    for (var item in cart.items) {
      itemsByCompany.putIfAbsent(item.companyName, () => []).add(item);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Header(isCartPage: true),
      ),
      bottomNavigationBar: const Navigation(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/banner.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    'Shopping Cart',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 3, color: Colors.black45, offset: Offset(1, 1))],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Home — Shopping Cart',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            if (cart.items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              Column(
                children: itemsByCompany.entries.map((entry) {
                  final companyName = entry.key;
                  final items = entry.value;

                  // Calculate subtotal for this company
                  double companySubtotal = cart.companyTotal(companyName);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company header with subtotal
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                companyName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'Subtotal: ₹${companySubtotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),

                        // Table header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: const [
                              Expanded(flex: 2, child: Text('Image', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 3, child: Text('Products', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('Qty Increase By', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                              SizedBox(width: 50),
                            ],
                          ),
                        ),

                        const Divider(),

                        // Items for this company
                        ...items.map((item) {
                          incrementValues.putIfAbsent(item.id, () => 1.0);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                // Product image
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    item.imagePath, // Product image
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(flex: 3, child: Text(item.name)),
                                Expanded(child: Text('₹${item.price.toStringAsFixed(2)}')),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove, color: Colors.green),
                                        onPressed: () {
                                          setState(() {
                                            final val = incrementValues[item.id] ?? 1.0;
                                            cart.decreaseQuantity(item, by: val);
                                          });
                                        },
                                      ),
                                      DropdownButton<double>(
                                        value: incrementValues[item.id],
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() {
                                              incrementValues[item.id] = val;
                                            });
                                          }
                                        },
                                        items: const [
                                          DropdownMenuItem(value: 0.5, child: Text("0.5")),
                                          DropdownMenuItem(value: 1.0, child: Text("1")),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, color: Colors.green),
                                        onPressed: () {
                                          setState(() {
                                            final val = incrementValues[item.id] ?? 1.0;
                                            cart.increaseQuantity(item, by: val);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Text('${item.quantity}')),
                                Expanded(child: Text('₹${(item.price * item.quantity).toStringAsFixed(2)}')),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    cart.removeItem(item.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // Continue Shopping
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CONTINUE SHOPPING', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Cart Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                color: Colors.grey[100],
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cart Total', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total (Incl GST)', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '₹${cart.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Note: GST (Goods and Services Tax) of 5% is included in the total price.',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          // Checkout logic
                        },
                        child: const Text('PROCEED TO CHECKOUT', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
