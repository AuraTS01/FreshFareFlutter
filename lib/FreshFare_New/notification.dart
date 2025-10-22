// FreshFare_New/notification.dart
import 'package:flutter/material.dart';
import 'package:freshfare/FreshFare_New/header.dart';
import 'package:freshfare/FreshFare_New/navigation.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      bottomNavigationBar: Navigation(currentIndex: 4),
      body: Center(
        child: Text(
          'Notification page is under development.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
