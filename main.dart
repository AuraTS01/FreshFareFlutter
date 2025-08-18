import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfare/freshfare/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
