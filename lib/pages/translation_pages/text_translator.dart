import 'dart:core';

import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:langconnect/utilities/translation_service.dart';

class Translator extends StatefulWidget {
  const Translator({super.key});

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  Map<String, String> langcodes = {
    "English": "en",
    "Spanish": "es",
    "French": "fr",
    "German": "de",
    "Italian": "it",
    "Portuguese": "pt",
    "Russian": "ru",
    "Chinese": "zh-cn",
    "Japanese": "ja",
    "Korean": "ko",
    "Arabic": "ar",
    "Hindi": "hi",
    "Bengali": "bn",
    "Urdu": "ur",
    "Turkish": "tr",
    "Vietnamese": "vi",
    "Thai": "th",
    "Indonesian": "id",
    "Malay": "ms",
    "Filipino": "tl",
    "Swahili": "sw",
    "Persian": "fa",
  };
  Map<String, String> langFlags = {
    "English": "GB",
    "Spanish": "ES",
    "French": "FR",
    "German": "DE",
    "Italian": "IT",
    "Portuguese": "PT",
    "Russian": "RU",
    "Chinese": "CN",
    "Japanese": "JP",
    "Korean": "KR",
    "Arabic": "SA",
    "Hindi": "IN",
    "Bengali": "BD",
    "Urdu": "PK",
    "Turkish": "TR",
    "Vietnamese": "VN",
    "Thai": "TH",
    "Indonesian": "ID",
    "Malay": "MY",
    "Filipino": "PH",
    "Swahili": "TZ",
  };
  List<String> languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Italian",
    "Portuguese",
    "Russian",
    "Chinese",
    "Japanese",
    "Korean",
    "Arabic",
    "Hindi",
    "Bengali",
    "Urdu",
    "Turkish",
    "Vietnamese",
    "Thai",
    "Indonesian",
    "Malay",
    "Filipino",
    "Swahili",
  ];
  String selectedValueOne = "English";
  String selectedValue = "English";
  String? translatedTextHolder;
  void _onChangedFirst(String? value) {
    setState(() {
      selectedValueOne = value!;
    });
  }

  void _onChanged(String? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  void _onSwap() {
    String temp = selectedValueOne;
    setState(() {
      selectedValueOne = selectedValue;
      selectedValue = temp;
    });
  }

  void _translateText() async {
    String textToTranslate = inputController.text;
    String targetLanguage = langcodes[selectedValue]!;
    String translatedText =
        await TranslationService().translate(textToTranslate, targetLanguage);
    setState(() {
      translatedTextHolder = translatedText;
    });
    print("Translated Text: $translatedTextHolder");
  }

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LanguageSelectionRow(
                languages: languages,
                langFlags: langFlags,
                selectedValueOne: selectedValueOne,
                selectedValue: selectedValue,
                onChangedFirst: _onChangedFirst,
                onChangedSecond: _onChanged,
                onSwap: _onSwap,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: UntranslatedTextInput(
              language: selectedValueOne,
              controller: inputController,
              onTranslate: _translateText),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TranslatedText(
            toTranslateLanguage: selectedValue,
            translatedText: translatedTextHolder ?? "Translation will appear here",
          ),
        ),
      ],
    );
  }
}

class LanguageSelectionRow extends StatelessWidget {
  final List<String> languages;
  final Map<String, String> langFlags;
  final String selectedValueOne;
  final String selectedValue;
  final ValueChanged<String?> onChangedFirst;
  final ValueChanged<String?> onChangedSecond;
  final VoidCallback onSwap;

  const LanguageSelectionRow({
    super.key,
    required this.languages,
    required this.langFlags,
    required this.selectedValueOne,
    required this.selectedValue,
    required this.onChangedFirst,
    required this.onChangedSecond,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: DropdownButton(
            items: languages.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      langFlags[value]!,
                      height: 24,
                      width: 24,
                      shape: const Circle(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            icon: const SizedBox.shrink(),
            underline: Container(),
            value: selectedValueOne,
            onChanged: onChangedFirst,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: onSwap,
          icon: Icon(
            Icons.swap_horiz,
            color: Colors.blue[900],
            size: 30,
          ),
        ),
        const SizedBox(width: 11),
        Flexible(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButton(
              items: languages.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        langFlags[value]!,
                        height: 24,
                        width: 24,
                        shape: const Circle(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              icon: null,
              iconSize: 0,
              underline: Container(),
              value: selectedValue,
              onChanged: onChangedSecond,
            ),
          ),
        ),
      ],
    );
  }
}

class UntranslatedTextInput extends StatelessWidget {
  final String language;
  final TextEditingController controller;
  final VoidCallback onTranslate;
  const UntranslatedTextInput({
    super.key,
    required this.language,
    required this.controller,
    required this.onTranslate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[900],
                ),
              ),
            ),
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter text to translate',
              ),
              cursorColor: Colors.black,
              controller: controller,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  overlayColor: Colors.white.withOpacity(0.3),
                  animationDuration: const Duration(milliseconds: 500),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: onTranslate,
                child: const Text(
                  "Translate",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TranslatedText extends StatelessWidget {
  final String toTranslateLanguage;
  final String translatedText;

  const TranslatedText({
    super.key,
    required this.toTranslateLanguage,
    required this.translatedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                toTranslateLanguage,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[900],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(translatedText)
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
