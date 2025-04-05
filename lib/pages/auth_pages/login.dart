import 'package:flutter/material.dart';
import 'package:langconnect/pages/auth_pages/signup.dart';
import 'package:langconnect/pages/translation_pages/text_translation.dart';
import 'package:langconnect/utilities/authservice.dart';
import 'package:langconnect/utilities/users_service.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const LoginBottomNavBar(),
        body: ListView(
          children: [
            Flex(
              mainAxisSize: MainAxisSize.min,
              direction: Axis.vertical,
              children: [
                const TranslateIcon(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          LoginText(),
                          SizedBox(height: 50),
                          EmailField(),
                          SizedBox(height: 60),
                          PasswordField(),
                          SizedBox(height: 60),
                          LoginBtn(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Password",
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
      controller: passwordController,
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Email",
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
      controller: _emailController,
    );
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

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key});

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
          String message = await _authService.signin(
              email: _emailController.text, password: passwordController.text);
          print(message);
          if (message == "Success") {
            UsersService _usersService = UsersService();
            String username = await _usersService.getUserInformation(email: _emailController.text, field: "username");
            print(username);
            await _usersService.addUser(
                email: _emailController.text,
                username: username);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const TextTranslation()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 2),
            ));
          }
        },
        child: const Text("Login",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)));
  }
}

class LoginBottomNavBar extends StatelessWidget {
  const LoginBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Signup()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "Login",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
