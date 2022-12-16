import 'package:flutter/material.dart';

class Apptheme {
  static final theme = ThemeData.dark().copyWith(
      accentColor: Colors.red,
      colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.red),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: Colors.red));
}
