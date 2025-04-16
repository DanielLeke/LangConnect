import 'package:flutter/material.dart';
import 'package:langconnect/utilities/authservice.dart';

TextEditingController _oldPasswordController = TextEditingController();
TextEditingController _newPasswordController = TextEditingController();

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

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
                  ChangePasswordText(),
                  SizedBox(
                    height: 50,
                  ),
                  OldPasswordField(),
                  SizedBox(
                    height: 80,
                  ),
                  NewPasswordField(),
                  SizedBox(
                    height: 80,
                  ),
                  ChangePasswordBtn()
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

class ChangePasswordText extends StatelessWidget {
  const ChangePasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "Change Password",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

class OldPasswordField extends StatelessWidget {
  const OldPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Enter Your Old Password",
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
      controller: _oldPasswordController,
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Enter Your New Password",
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
      controller: _newPasswordController,
    );
  }
}

class ChangePasswordBtn extends StatelessWidget {
  const ChangePasswordBtn({super.key});

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
          String updatePasswordResult = await _authService.updatePassword(
              oldPassword: _oldPasswordController.text,
              newPassword: _newPasswordController.text);
          if (updatePasswordResult == "Success") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Password successfully changed 👍")));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "An error occurred: $updatePasswordResult. Please try again")));
          }
        },
        child: const Text("Change Password",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)));
  }
}
