import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal/views/main/discover_screen.dart';
import 'package:josequal/views/main/favorite_screen.dart';
import 'package:josequal/views/main/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const DiscoverScreen(),
    const FavoriteScreen(),
  ];
  final List<String> _names = [
    'Home',
    'Discover',
    'Favorite',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _names[_currentIndex],
          style: GoogleFonts.montserrat().copyWith(
              color: Colors.deepPurpleAccent.shade100,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ),
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
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
