import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/delivery.dart';
import 'package:freshfare/freshfare/admin.dart';
import 'package:freshfare/freshfare/company.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<bool> isLoggedIn() async { 
    final prefs = await SharedPreferences.getInstance(); 
    return prefs.getString('userEmail') != null; 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Cambria"),
      themeMode: ThemeMode.system,
      title: 'FreshFare',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
} 
