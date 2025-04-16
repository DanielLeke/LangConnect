import 'package:flutter/material.dart';
import 'package:langconnect/pages/auth_pages/login.dart';
import 'package:langconnect/pages/auth_pages/signup.dart';
import 'package:langconnect/utilities/authservice.dart';
import 'package:langconnect/utilities/users_service.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _newEmailcontroller = TextEditingController();

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const TranslateIcon(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  ChangeEmailText(),
                  SizedBox(
                    height: 50,
                  ),
                  PasswordField(),
                  SizedBox(
                    height: 80,
                  ),
                  NewEmailField(),
                  SizedBox(
                    height: 80,
                  ),
                  ChangeEmailBtn()
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class TranslateIcon extends StatelessWidget {
  const TranslateIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
          color: Colors.grey[200],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.translate_sharp,
          size: 85,
          color: Colors.blue[900],
        ),
      ),
    );
  }
}

class ChangeEmailText extends StatelessWidget {
  const ChangeEmailText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "Change Email",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Enter Your Password",
          style: TextStyle(color: Colors.grey),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.blue[900]!, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.blue[900]!, width: 2)),
      ),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _passwordController,
    );
  }
}

class NewEmailField extends StatelessWidget {
  const NewEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Enter Your New Email",
          style: TextStyle(color: Colors.grey),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.blue[900]!, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.blue[900]!, width: 2)),
      ),
      cursorColor: Colors.black,
      obscureText: false,
      controller: _newEmailcontroller,
    );
  }
}

class ChangeEmailBtn extends StatelessWidget {
  const ChangeEmailBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.3)),
          animationDuration: const Duration(milliseconds: 500),
          shadowColor: WidgetStatePropertyAll(Colors.grey[300]),
          elevation: const WidgetStatePropertyAll(5),
          backgroundColor: WidgetStatePropertyAll(Colors.blue[900]),
          fixedSize: const WidgetStatePropertyAll(Size(350, 50)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
        onPressed: () async {
          Authservice _authService = Authservice();
          UsersService _usersService = UsersService();
          String updateEmailResult = await _authService.updateEmail(
              password: _passwordController.text,
              newEmail: _newEmailcontroller.text);
          String updateFirebaseEmailResult;
          if (updateEmailResult == "Success") {
            updateFirebaseEmailResult = await _usersService.updateInfo(email: emailController.text.isNotEmpty ? emailController.text : loginEmailController.text, field: "email", newInfo: _newEmailcontroller.text);
            if (updateFirebaseEmailResult == "Success") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please check your email to continue. After, sign in to the app again")));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "An error occurred: $updateEmailResult. Please try again")));
          }
        },
        child: const Text("Change Email",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)));
  }
}
