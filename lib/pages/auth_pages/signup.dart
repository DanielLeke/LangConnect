import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          SignupText(),
                          EmailField(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
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
        label: Text("Email"),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.blue[900]!, width: 2)
        ),
      ),
      obscureText: false,
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
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
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
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12)
        )
      ),
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