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
            Container(
              color: Colors.grey[100],
              child: Icon(
                Icons.translate_sharp,
                size: 85,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      )
    );
  }
}