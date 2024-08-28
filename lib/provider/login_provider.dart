import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider({required this.prefs}) {
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }
  final SharedPreferences prefs;
  String? errorMessage;
  late bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    if (username == 'username' && password == 'password') {
      errorMessage = null;
      _isLoggedIn = true;
      await prefs.setBool('isLoggedIn', true);
    } else {
      errorMessage = 'Invalid username or password';
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }
}
