import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:langconnect/utilities/favorites_service.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoriteItems();
  }
}

class FavoriteItems extends StatefulWidget {
  const FavoriteItems({super.key});

  @override
  State<FavoriteItems> createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  late Future<List<Map<String, String>>> future;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    future = FavoritesService().getFavorites(email);
  }

  void _reloadFavorites() {
    setState(() {
      _loadFavorites(); // Reload the favorites
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading favorites"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No favorites found"));
        } else {
          List<Map<String, String>> favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              Map<String, String> favorite = favorites[index];
              return ListTile(
                title: Text(favorite["originalText"] ?? "No original text"),
                subtitle:
                    Text(favorite["translatedText"] ?? "No translated text"),
                trailing: DeleteBtn(
                  index: index,
                  onDelete: _reloadFavorites, // Pass the reload callback
                ),
              );
            },
          );
        }
      },
    );
  }
}

class DeleteBtn extends StatelessWidget {
  final int index;
  final VoidCallback onDelete;

  const DeleteBtn({
    super.key,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        await FavoritesService().removeFromFavorites(
          FirebaseAuth.instance.currentUser!.email!,
          index,
        );
        onDelete(); // Trigger the reload callback
      },
    );
  }
}
