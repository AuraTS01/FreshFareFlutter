// FreshFare_New/profile.dart
import 'package:flutter/material.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      bottomNavigationBar: Navigation(currentIndex: 5),
      body: Center(
        child: Text(
          'Profile page is under development.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
