import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  Future<void> addToFavorites(
      String email, Map<String, String> newFavorite) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;

    try {
      // Fetch the existing favorites
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("favorites")
          .get();

      List<Map<String, String>> favorites = [];

      if (docSnapshot.exists) {
        // If the document exists, get the current favorites
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["favorites"] != null) {
          favorites = List<Map<String, String>>.from(
            (data["favorites"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      }

      print("Existing favorites: $favorites");
      // Add the new favorite to the list
      favorites.add(newFavorite);
      print("Updated favorites: $favorites");

      await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("favorites")
          .set(
        {
          "favorites": favorites,
        },
        SetOptions(merge: true), // Merge with existing data
      );

      print("Added to favorites successfully!");
    } catch (e) {
      print("Error adding to favorites: $e");
    }
  }

  Future<List<Map<String, String>>> getFavorites(String email) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;
    List<Map<String, String>> favorites = [];
    try {
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("favorites")
          .get();

      if (docSnapshot.exists) {
        // If the document exists, get the current favorites
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["favorites"] != null) {
          favorites = List<Map<String, String>>.from(
            (data["favorites"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      } else {
        print("No favorites found for this user.");
      }
    } catch (e) {
      print("Error fetching favorites: $e");
    }
    return favorites;
  }

  Future<void> removeFromFavorites(
      String email, int favoriteIndex) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;
    try {
      // Fetch the existing favorites
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("favorites")
          .get();

      List<Map<String, String>> favorites = [];

      if (docSnapshot.exists) {
        // If the document exists, get the current favorites
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["favorites"] != null) {
          favorites = List<Map<String, String>>.from(
            (data["favorites"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      }
      // Remove the specified favorite
      favorites.removeAt(favoriteIndex);

      // Update Firestore with the updated list
      await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("favorites")
          .set(
        {
          "favorites": favorites,
        },
        SetOptions(merge: true), // Merge with existing data
      );

      print("Removed from favorites successfully!");
    } catch (e) {
      print(e);
    }
  }
}
