import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryService {
  Future<void> addToHistory(
      String email, Map<String, String> newItem) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;

    try {
      // Fetch the existing history
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("history")
          .get();

      List<Map<String, String>> history = [];

      if (docSnapshot.exists) {
        // If the document exists, get the current history
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["history"] != null) {
          history = List<Map<String, String>>.from(
            (data["history"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      }
      // Add the new item to the history list
      history.add(newItem);

      await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("history")
          .set(
        {
          "history": history,
        },
        SetOptions(merge: true), // Merge with existing data
      );
    } catch (e) {
      print("Error adding to history: $e");
    }
  }

  Future<List<Map<String, String>>> getHistory(String email) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;
    List<Map<String, String>> history = [];
    try {
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("history")
          .get();

      if (docSnapshot.exists) {
        // If the document exists, get the current history
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["history"] != null) {
          history = List<Map<String, String>>.from(
            (data["history"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      } else {
        print("No history found for this user.");
      }
    } catch (e) {
      print("Error fetching history: $e");
    }
    return history;
  }

  Future<void> removeFromHistory(
      String email, int historyIndex) async {
    FirebaseFirestore firestore_db = FirebaseFirestore.instance;
    try {
      // Fetch the existing history
      DocumentSnapshot docSnapshot = await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("history")
          .get();

      List<Map<String, String>> history = [];

      if (docSnapshot.exists) {
        // If the document exists, get the current history
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        if (data["history"] != null) {
          history = List<Map<String, String>>.from(
            (data["history"] as List)
                .map((item) => Map<String, String>.from(item)),
          );
        }
      }
      // Remove the specified history item
      history.removeAt(historyIndex);

      // Update Firestore with the updated list
      await firestore_db
          .collection("users")
          .doc(email)
          .collection("user_content")
          .doc("history")
          .set(
        {
          "history": history,
        },
        SetOptions(merge: true), // Merge with existing data
      );
    } catch (e) {
      print("Error removing from history: $e");
    }
  }
}
