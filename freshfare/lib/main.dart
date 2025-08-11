import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freshfare/firebase_options.dart';
import 'package:freshfare/freshfare/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.system,
      title: 'Fresh Fare',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
     
    );
  }
}
