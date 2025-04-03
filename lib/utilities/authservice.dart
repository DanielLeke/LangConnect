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
    }
    catch (e) {
      message = "An unexpected error occurred. Please try again.";
    }
    return message;
  }

  Future<void> signout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
