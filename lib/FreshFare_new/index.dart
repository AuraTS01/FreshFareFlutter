// FreshFare_New/index.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:freshfare/FreshFare_New/cartprovider.dart';
import 'package:freshfare/FreshFare_New/cart.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin {
  bool showItems = false;
  String selectedPincode = '';
  int _currentIndex = 0;
  String pincodeError = '';

  final List<String> items = [
    'Chicken',
    'Fish',
    'Prawns',
    'Mutton',
    'Mutton - Boti',
    'Mutton - Liver',
    'Beef',
    'Beef - Liver',
    'Beef - Boti',
    'Quail',
    'Duck',
  ];

  final List<String> validPincodes = ['641104', '641301', '641302'];
  final TextEditingController _pincodeController = TextEditingController();

  final List<String> offerImages = [
    'assets/offer1.png',
    'assets/offer2.png',
  ];

  List<Map<String, dynamic>> butcherShops = [];
  bool isLoadingShops = false;
  String shopFetchError = '';

  @override
  void initState() {
    super.initState();
    fetchButcherShops();
  }

  Future<void> fetchButcherShops() async {
    setState(() {
      isLoadingShops = true;
      shopFetchError = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.4/FreshFareFlutter/lib/FreshFare_New/database/get_companies.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> companies = data['companies'];
          setState(() {
            butcherShops =
                companies.map((c) => Map<String, dynamic>.from(c)).toList();
          });
        } else {
          shopFetchError = 'Failed: ${data['message'] ?? 'Unknown error'}';
        }
      } else {
        shopFetchError = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      shopFetchError = 'Error fetching shops: $e';
    } finally {
      setState(() => isLoadingShops = false);
    }
  }

  void _showLocationDialog() {
    setState(() {
      pincodeError = '';
    });

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text("Change Pincode",
                  style: TextStyle(color: Colors.green)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _pincodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your pincode",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (pincodeError.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(pincodeError,
                          style: const TextStyle(color: Colors.red)),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final input = _pincodeController.text.trim();
                    if (validPincodes.contains(input)) {
                      setState(() => selectedPincode = input);
                      Navigator.pop(context);
                    } else {
                      setState(() => pincodeError =
                          "Delivery only in Mettupalayam and Karamadai.");
                    }
                  },
                  child: const Text("Confirm",
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showShopProducts(BuildContext context, Map<String, dynamic> shop) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        final List<dynamic> products = shop['selling_items'] ?? [];
        final cart = Provider.of<CartProvider>(context, listen: false);

        return AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(height: 12),
                Text(shop['company_name'] ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green)),
                const SizedBox(height: 6),
                Text(
                    "📧 ${shop['email'] ?? 'N/A'} | 📞 ${shop['contact_number'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.grey)),
                const Divider(),
                if (products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No products available"),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      final item = products[i];
                      final itemName = item['name'];
                      final price = double.tryParse(item['price'].toString()) ?? 100.0;

                      return ListTile(
                        title: Text(itemName),
                        subtitle: Text("₹${price.toStringAsFixed(2)}"),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            final newItem = CartItem(
                              id: "${shop['company_name']}_${itemName}",
                              name: itemName,
                              price: price,
                              quantity: 1,
                              companyName: shop['company_name'] ?? 'Unknown Shop',
                            );
                            cart.addItem(newItem);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$itemName added to cart'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text("Add"),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          );
        },
        isCartPage: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Text(
              selectedPincode.isEmpty
                  ? "Please enter your area pincode"
                  : "Delivering to: $selectedPincode",
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: _showLocationDialog,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              child: const Text("Change Location"),
            ),
          ),
          const SizedBox(height: 20),

          // All Items Dropdown
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                ListTile(
                  tileColor: Colors.green,
                  title: const Text("All Items",
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    showItems
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  onTap: () => setState(() => showItems = !showItems),
                ),
                if (showItems)
                  ...items
                      .map((e) => ListTile(
                            title: Text(e),
                          ))
                      .toList(),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: offerImages.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(path, fit: BoxFit.cover, width: 1000),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          const Text("Choose Your Butcher Shops",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green)),

          const SizedBox(height: 8),
          if (isLoadingShops)
            const Center(child: CircularProgressIndicator())
          else if (shopFetchError.isNotEmpty)
            Center(child: Text(shopFetchError, style: const TextStyle(color: Colors.red)))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: butcherShops.length,
              itemBuilder: (context, index) {
                final shop = butcherShops[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(shop['company_name'] ?? 'Unknown Shop'),
                    subtitle: Text(
                        "📧 ${shop['email'] ?? 'N/A'} | 📞 ${shop['contact_number'] ?? 'N/A'}"),
                    onTap: () => _showShopProducts(context, shop),
                  ),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: Navigation(currentIndex: _currentIndex),
    );
  }
}
