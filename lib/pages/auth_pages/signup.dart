import 'package:flutter/material.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController usernameController = TextEditingController();

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(),
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
                        SignupText(),
                        SizedBox(height: 50),
                        UsernameField(),
                        SizedBox(height: 60),
                        EmailField(),
                        SizedBox(height: 60),
                        PasswordField(),
                        SizedBox(height: 60),
                        SignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "Username",
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
      controller: usernameController,
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
      controller: emailController,
    );
  }
}

class SignupText extends StatelessWidget {
  const SignupText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "Create Account",
        style: TextStyle(
            fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),
      ),
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

class SignupBtn extends StatelessWidget {
  const SignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shadowColor: WidgetStatePropertyAll(Colors.grey[300]),
          elevation: const WidgetStatePropertyAll(5),
          backgroundColor: WidgetStatePropertyAll(Colors.blue[900]),
          fixedSize: const WidgetStatePropertyAll(Size(350, 50)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
        onPressed: () {},
        child: const Text("Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5)));
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
            "Already have an account?",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: (){}, 
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          )
        ],
      ),
    );
  }
}
