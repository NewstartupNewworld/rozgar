import 'package:flutter/material.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  bool isDarkMode = false;
  final List<VoidCallback> listeners = [];

  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    for (var listener in listeners) {
      listener();
    }
  }
}