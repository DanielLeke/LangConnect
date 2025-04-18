import 'package:flutter/material.dart';
import 'package:langconnect/pages/others/about.dart';
import 'package:langconnect/pages/others/favorites.dart';
import 'package:langconnect/pages/others/history.dart';
import 'package:langconnect/pages/others/profile_pages/profile.dart';
import 'package:langconnect/pages/translation_pages/camera_page.dart';
import 'package:langconnect/pages/translation_pages/chat_page.dart';
import 'package:langconnect/pages/translation_pages/text_translator.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const HomeAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue[900],
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HomeBottomNavBar extends StatefulWidget {
  final Function(int) onTap;

  const HomeBottomNavBar({super.key, required this.onTap});

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
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

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  int _drawerIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _drawerIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SafeArea(
          child: Scaffold(
            backgroundColor: index == 0 ? Colors.blue[900] : Colors.white,
            appBar: index == 0 ? null : AppBar(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              title: const Text(
                "About",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: drawerpages[index],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
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
            leading: const Icon(Icons.person),
            selected: _drawerIndex == 0,
            selectedColor: Colors.blue[900],
            title: const Text("Profile"),
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



List<Widget> navpages = const [
  ChatPage(),
  CameraPage(),
  Translator(),
  History(),
  Favorites()
];
List<Widget> drawerpages = const [Profile(), About()];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _navIndex = 2;

  void updateNavIndex(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(title: _navIndex == 0
          ? "Chat"
          : _navIndex == 1
              ? "Camera"
              : _navIndex == 2
                  ? "Translate"
                  : _navIndex == 3
                      ? "History"
                      : "Favorites",),
      drawer: const HomeDrawer(),
      bottomNavigationBar: HomeBottomNavBar(onTap: updateNavIndex),
      body: navpages[_navIndex],
    );
  }
}
