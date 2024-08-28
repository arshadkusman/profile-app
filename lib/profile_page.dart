import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums.dart';
import 'package:flutter_application_1/next_page.dart';
import 'package:provider/provider.dart';

import 'provider/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.onLogout}) : super(key: key);

  final VoidCallback onLogout;

  void _toggleTheme(
      BuildContext context, ValueNotifier<bool> isDarkModeNotifier) {
    final newMode = !isDarkModeNotifier.value;
    isDarkModeNotifier.value = newMode;
    Provider.of<ThemeProvider>(context, listen: false)
        .setMode(newMode ? AppThemeMode.dark : AppThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkModeNotifier =
        ValueNotifier<bool>(themeProvider.mode == AppThemeMode.dark);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/Ronaldo.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              'CRISTIANO RONALDO',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Professional Footballer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, _) {
                return ElevatedButton(
                  onPressed: () => _toggleTheme(context, isDarkModeNotifier),
                  child: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Text('Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}
