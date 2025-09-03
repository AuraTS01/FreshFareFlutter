import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/home.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:freshfare/freshfare/login.dart';
import 'package:provider/provider.dart';


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
      child: MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins"),
      themeMode: ThemeMode.system,
      title: 'Fresh Fare',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
     
    );
  }
}
