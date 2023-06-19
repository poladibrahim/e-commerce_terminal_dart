import 'package:commerce_flutter/pages/login.dart';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 7, 7, 7),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color.fromARGB(255, 7, 55, 94),
          unselectedItemColor: Color.fromARGB(255, 120, 159, 192),
          selectedLabelStyle: TextStyle(fontSize: 18.0),
          unselectedLabelStyle: TextStyle(fontSize: 16.00),
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 27),
        ),
      ),
    );
  }
}
