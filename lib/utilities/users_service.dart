import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String email, required String username}) async {
    try {
      await _firestore.collection('users').doc(email).set({
        'email': email,
        'username': username,
      }, SetOptions(merge: true));
      print('User added successfully!');
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  Future<String> getUserInformation(
      {required String email, required String field}) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(email).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print("User data: ${userData[field]}");
        return userData[field] ?? "Field not found";
      } else {
        print("User not found");
        return "User not found";
      }
    } catch (e) {
      print("Error fetching user information: $e");
      return "Error fetching user information";
    }
  }

  Future<String> updateInfo({
    required String email,
    required String field,
    required String newInfo,
  }) async {
    try {
      if (field == 'email') {
        // Handle email update by creating a new document
        DocumentSnapshot oldDoc =
            await _firestore.collection('users').doc(email).get();

        if (oldDoc.exists) {
          // Copy data from the old document
          Map<String, dynamic> userData = oldDoc.data() as Map<String, dynamic>;
          userData['email'] = newInfo; // Update the email field

          // Create a new document with the updated email as the document ID
          await _firestore.collection('users').doc(newInfo).set(userData);

          // Delete the old document
          await _firestore.collection('users').doc(email).delete();

          print("Email updated and document renamed successfully!");
          return "Success";
        } else {
          print("Old document not found");
          return "User not found";
        }
      } else {
        // Update other fields normally
        await _firestore.collection('users').doc(email).update({
          field: newInfo,
        });
        print("User information updated successfully!");
        return "Success";
      }
    } catch (e) {
      print("Error updating user information: $e");
      return "Error updating user information";
    }
  }
}
