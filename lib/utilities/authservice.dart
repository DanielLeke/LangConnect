// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  Future<String> signup(
      {required String email, required String password}) async {
    String message = "";
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      message = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          message = "The password provided is too weak.";
          break;
        case "email-already-in-use":
          message = "An account already exists for that email.";
          break;
        default:
          message = "An error occurred. Please try again.";
          break;
      }
    } catch (e) {
      message = "An unexpected error occurred. Please try again.";
      print(e);
    }
    return message;
  }

  Future<String> signin(
      {required String email, required String password}) async {
    String message = "";
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      message = "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          message = 'No user found for that email.';
          break;
        case "wrong-password":
          message = 'Wrong password provided for that user.';
          break;
        case "invalid-credential":
          message = "You entered an invalid email/password.";
          break;
        default:
          message = "An error occurred. ${e.message}";
          break;
      }
    } catch (e) {
      message = "An unexpected error occurred. Please try again.";
    }
    return message;
  }

  Future<void> signout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<String> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? email = user!.email;
      AuthCredential credential =
          EmailAuthProvider.credential(email: email!, password: oldPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return "An error occurred: ${e.message}";
    }
  }

  Future<String> updateEmail(
      {required String password, required String newEmail}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return "User is not signed in. Please log in again.";
      }

      // Reauthenticate the user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Update the email
      await user.verifyBeforeUpdateEmail(newEmail);
      await signin(email: newEmail, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return "The password is incorrect. Please try again.";
      } else if (e.code == 'user-mismatch') {
        return "The credential does not match the current user.";
      } else if (e.code == 'invalid-credential') {
        return "The supplied credential is invalid or malformed.";
      } else {
        return "An error occurred: ${e.message}";
      }
    } catch (e) {
      return "An unexpected error occurred: ${e.toString()}";
    }
  }
}
