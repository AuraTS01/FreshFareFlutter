// FreshFare_New/order_history.dart
import 'package:flutter/material.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      bottomNavigationBar: Navigation(currentIndex: 3),
      body: Center(
        child: Text(
          'Order History page is under development.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
