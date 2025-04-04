import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String email, required String username}) async {
    try {
      await _firestore.collection('users').doc(username).set({
        'email': email,
        'username': username,
      }, SetOptions(merge: true));
      print('User added successfully!');
    } catch (e) {
      print("Error adding user: $e");
    }
  }
}
