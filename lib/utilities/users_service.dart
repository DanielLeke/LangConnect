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
}
