import 'package:flutter/material.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const TranslateAppBar(),
      bottomNavigationBar: const TranslateBottomNavBar(),
    );
  }
}

class TranslateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TranslateAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: const Text(
        "Language Translator",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TranslateBottomNavBar extends StatefulWidget {
  const TranslateBottomNavBar({super.key});

  @override
  State<TranslateBottomNavBar> createState() => _TranslateBottomNavBarState();
}

class _TranslateBottomNavBarState extends State<TranslateBottomNavBar> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue[900],
      currentIndex: _selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: true,
      backgroundColor: Colors.grey[200],
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        _buildNavItem(Icons.mic, "Chat", 0),
        _buildNavItem(Icons.camera_alt, "Camera", 1),
        _buildNavItem(Icons.translate_sharp, "Translate", 2),
        _buildNavItem(Icons.history_rounded, "History", 3),
        _buildNavItem(Icons.favorite, "Favorites", 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index
              ? Colors.blue[900]!.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: _selectedIndex == index ? Colors.blue[900] : Colors.black,
          size: _selectedIndex == index ? 35 : 24,
        ),
      ),
      label: label,
    );
  }
}
