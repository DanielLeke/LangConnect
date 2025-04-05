import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const TranslateAppBar(),
    );
  }
}

class TranslateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TranslateAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: const Text(
        "Language Translator",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}