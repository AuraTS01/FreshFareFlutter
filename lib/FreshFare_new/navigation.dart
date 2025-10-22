// FreshFare_New/navigation.dart
import 'package:flutter/material.dart';
import 'package:freshfare/FreshFare_New/index.dart';

import 'package:freshfare/FreshFare_New/cart.dart';
import 'package:freshfare/FreshFare_New/order_history.dart';
import 'package:freshfare/FreshFare_New/notification.dart';
import 'package:freshfare/FreshFare_New/profile.dart';
import 'package:freshfare/FreshFare_New/search.dart';

class Navigation extends StatelessWidget {
  final int currentIndex;

  const Navigation({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return; // Prevent reload of same page

    Widget nextPage;

    switch (index) {
      case 0:
        nextPage = const IndexPage();
        break;
      case 1:
        nextPage = const SearchPage();
        break;
      case 2:
        nextPage = const CartPage();
        break;
      case 3:
        nextPage = const OrderHistoryPage();
        break;
      case 4:
        nextPage = const NotificationPage();
        break;
      case 5:
        nextPage = const ProfilePage();
        break;
      default:
        nextPage = const IndexPage();
    }

    // Smooth iPhone-like transition
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => nextPage,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: const Offset(0.05, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOut));
        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notification'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
