import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(SharedPreferences prefs) {
    _prefs = prefs;
    _mode = AppThemeMode.values[prefs.getInt('theme') ?? 0];
  }

  late SharedPreferences _prefs;
  AppThemeMode _mode = AppThemeMode.light;

  AppThemeMode get mode => _mode;

  Future<void> setMode(AppThemeMode mode) async {
    _mode = mode;
    await saveToCache();
    Future.delayed(Duration.zero, notifyListeners);
  }

  Future<void> saveToCache() async {
    await _prefs.setInt('theme', _mode.index);
  }
}
