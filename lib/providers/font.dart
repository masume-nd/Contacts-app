import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontProvider extends ChangeNotifier {
  // Default font is 'Roboto'
  String _fontFamily = 'Roboto';

  String get fontFamily => _fontFamily;

  // Method to change font family
  void changeFont(String font) {
    _fontFamily = font;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to get the current font style using Google Fonts
  TextStyle getFontStyle(double fontSize) {
    return GoogleFonts.getFont(_fontFamily, fontSize: fontSize);
  }
}