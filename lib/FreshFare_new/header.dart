// FreshFare_New/header.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freshfare/FreshFare_New/cartprovider.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onCartTap;
  final bool isCartPage;

  const Header({
    Key? key,
    this.onCartTap,
    this.isCartPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalPrice = cartProvider.totalAmount.toStringAsFixed(2);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 12),

          // Logo
          Image.asset(
            'assets/logo.png',
            height: 40,
          ),
          const SizedBox(width: 8),

          // Brand Name
          RichText(
            text: const TextSpan(
              text: 'F',
              style: TextStyle(
                color: Color(0xFF228B22),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
              ),
              children: [
                TextSpan(
                  text: 'resh ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'F',
                  style: TextStyle(
                    color: Color(0xFF228B22),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'are',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Total Price
          Text(
            '₹$totalPrice',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(width: 12),

          // Cart Icon
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: isCartPage ? const Color(0xFF228B22) : Colors.grey,
              size: 28,
            ),
            onPressed: onCartTap ?? () {},
          ),

          const SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
