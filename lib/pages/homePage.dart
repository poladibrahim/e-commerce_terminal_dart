import 'package:commerce_flutter/model/userModel.dart';
import 'package:commerce_flutter/pages/cart.dart';
import 'package:commerce_flutter/pages/product.dart';
import 'package:commerce_flutter/pages/searchProduct.dart';
import 'package:commerce_flutter/pages/userPage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  const MyHomePage({required this.user});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User user;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  late final List<Widget> _tabs = [
    const ProductPage(),
    const SearchPage(),
    CartPage(
      user: user,
    ),
    UserPage(
      user: user,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
