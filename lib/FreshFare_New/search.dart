// FreshFare_New/search.dart
import 'package:flutter/material.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      bottomNavigationBar: Navigation(currentIndex: 1),
      body: Center(
        child: Text(
          'Search page is under development.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
