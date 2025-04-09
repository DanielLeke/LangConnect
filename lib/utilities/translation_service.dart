import 'package:translator/translator.dart';
class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate(String text, String targetLanguage) async {
    try {
      final translation = await _translator.translate(text, to: targetLanguage);
      return translation.text;
    } catch (e) {
      print("Error during translation: $e");
      return 'An error occurred'; // Return the original text in case of an error
    }
  }
}