import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Initial theme state
  bool _isDarkTheme = false; // Default: light theme

  bool get isDarkTheme => _isDarkTheme;

  // Toggle the theme and notify listeners
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners(); // Notify all listeners to rebuild with the new theme
  }

  // Light Theme Data
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          onPrimary: Colors.white, // Text/icon color on primary
        ),
      );

  // Dark Theme Data
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          onPrimary: Colors.black, // Text/icon color on primary
        ),
      );

  // Get the current theme
  ThemeData get currentTheme => _isDarkTheme ? darkTheme : lightTheme;
}
