import 'package:flutter/material.dart';

class Translator extends StatefulWidget {
  const Translator({super.key});

  @override
  State<Translator> createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  Map<String, IconData> langIcons = {
    
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(28)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    items: languages.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: const SizedBox.shrink(),
                    underline: Container(),
                    value: selectedValueOne,
                    onChanged: _onChangedFirst,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        String temp = selectedValueOne;
                        setState(() {
                          selectedValueOne = selectedValue;
                          selectedValue = temp;
                        });
                      },
                      icon: Icon(
                        Icons.swap_horiz,
                        color: Colors.blue[900],
                      )),
                  const SizedBox(width: 10),
                  DropdownButton(
                    items: languages.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: const SizedBox.shrink(),
                    underline: Container(),
                    value: selectedValue,
                    onChanged: _onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
