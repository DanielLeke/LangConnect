import 'package:flutter/material.dart';
import 'package:langconnect/pages/others/about.dart';
import 'package:langconnect/pages/others/favorites.dart';
import 'package:langconnect/pages/others/history.dart';
import 'package:langconnect/pages/others/settings.dart';
import 'package:langconnect/pages/translation_pages/camera_page.dart';
import 'package:langconnect/pages/translation_pages/chat_page.dart';

class TranslateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TranslateAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
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
  final Function(int) onTap;

  const TranslateBottomNavBar({super.key, required this.onTap});

  @override
  State<TranslateBottomNavBar> createState() => _TranslateBottomNavBarState();
}

class _TranslateBottomNavBarState extends State<TranslateBottomNavBar> {
  int _navIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _navIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue[900],
      currentIndex: _navIndex,
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
          color: _navIndex == index
              ? Colors.blue[900]!.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: _navIndex == index ? Colors.blue[900] : Colors.black,
          size: _navIndex == index ? 35 : 24,
        ),
      ),
      label: label,
    );
  }
}

class TranslateDrawer extends StatefulWidget {
  final Function(int) onTap;

  const TranslateDrawer({super.key, required this.onTap});

  @override
  State<TranslateDrawer> createState() => _TranslateDrawerState();
}

class _TranslateDrawerState extends State<TranslateDrawer> {
  int _drawerIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _drawerIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language Translator",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Translate your text easily",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            selected: _drawerIndex == 0,
            selectedColor: Colors.blue[900],
            title: const Text("Settings"),
            onTap: () {
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            selected: _drawerIndex == 1,
            selectedColor: Colors.blue[900],
            onTap: () {
              _onItemTapped(1);
            },
          ),
        ],
      ),
    );
  }
}

class Translator extends StatelessWidget {
  const Translator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Translator");
  }
}

List<Widget> navpages = const [
  ChatPage(),
  CameraPage(),
  Translator(),
  History(),
  Favorites()
];
List<Widget> drawerpages = const [Settings(), About()];

class TextTranslation extends StatefulWidget {
  const TextTranslation({super.key});

  @override
  State<TextTranslation> createState() => _TextTranslationState();
}

class _TextTranslationState extends State<TextTranslation> {
  int _navIndex = 2;
  int _drawerIndex = 0;
  bool viewNav = true;

  void updateNavIndex(int index) {
    setState(() {
      viewNav = true;
      _navIndex = index;
    });
  }

  void updateDrawerIndex(int index) {
    setState(() {
      viewNav = false;
      _drawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const TranslateAppBar(),
      drawer: TranslateDrawer(onTap: updateDrawerIndex),
      bottomNavigationBar: TranslateBottomNavBar(onTap: updateNavIndex),
      body: viewNav ? navpages[_navIndex] : drawerpages[_drawerIndex],
    );
  }
}
