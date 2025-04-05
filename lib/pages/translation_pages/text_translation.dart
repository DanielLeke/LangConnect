import 'package:flutter/foundation.dart';
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
      backgroundColor: Colors.grey[200],
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.mic,),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: "Camera",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.translate_sharp),
          label: "Translate",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Favorites",
        )
      ]
    );
  }
}