import 'package:flutter/material.dart';
import 'package:getitdone/app/features/profile/page/profile.dart';
import 'package:getitdone/extensions/context_extension.dart';
import '../done/done_page.dart';
import '../home/page/home_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DonePage(),
    const Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 1,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: _selectedIndex == 0
            ? Colors.blue
            : _selectedIndex == 2
                ? Colors.black
                : Colors.green,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.done),
            label: context.localizations.done,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: context.localizations.config,
          ),
        ],
      ),
    );
  }
}
