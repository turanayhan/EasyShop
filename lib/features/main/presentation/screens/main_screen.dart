import 'package:case1/features/main/presentation/widgets/custom_navigation.dart';
import 'package:case1/features/cart/presentation/screen/card_screen.dart';
import 'package:case1/features/home/presentation/screen/home_screen.dart';
import 'package:case1/features/profile/presentation/screen/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenAltState();
}

class _MainScreenAltState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    Text(""),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
