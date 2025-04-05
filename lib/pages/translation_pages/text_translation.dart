import 'package:flutter/material.dart';

int _mainIndex = 1;
int _selectedIndex = 2;
List<List<Widget>> pages = [
  [],
  [],
];

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const TranslateAppBar(),
      drawer: const TranslateDrawer(),
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
  const TranslateBottomNavBar({super.key});

  @override
  State<TranslateBottomNavBar> createState() => _TranslateBottomNavBarState();
}

class _TranslateBottomNavBarState extends State<TranslateBottomNavBar> {
  void _onItemTapped(int index) {
    setState(() {
      _mainIndex = 1;
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

class TranslateDrawer extends StatefulWidget {
  const TranslateDrawer({super.key});

  @override
  State<TranslateDrawer> createState() => _TranslateDrawerState();
}

class _TranslateDrawerState extends State<TranslateDrawer> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _mainIndex = 0;
      _selectedIndex = index;
    });
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
            selected: _selectedIndex == 1,
            selectedColor: Colors.blue[900],
            title: const Text("Settings"),
            onTap: () {
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            selected: _selectedIndex == 2,
            selectedColor: Colors.blue[900],
            onTap: () {
              _onItemTapped(2);
            },
          ),
        ],
      ),
    );
  }
}
