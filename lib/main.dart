import 'package:flutter/material.dart';
import 'package:flutter_application_1/enums.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/profile_page.dart';
import 'package:flutter_application_1/provider/login_provider.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(ProfileApp(
    prefs: prefs,
  ));
}

class ProfileApp extends StatefulWidget {
  final SharedPreferences prefs;

  ProfileApp({required this.prefs});

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  late final ValueNotifier<bool> _isLoggedInNotifier;

  @override
  void initState() {
    super.initState();
    _isLoggedInNotifier =
        ValueNotifier<bool>(widget.prefs.getBool('isLoggedIn') ?? false);
  }

  @override
  void dispose() {
    _isLoggedInNotifier.dispose();
    super.dispose();
  }

  void _updateLoggedInStatus(bool isLoggedIn) {
    setState(() {
      _isLoggedInNotifier.value = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(widget.prefs)),
        ChangeNotifierProvider(
            create: (_) => LoginProvider(prefs: widget.prefs))
      ],
      child: Consumer<ThemeProvider>(builder: (context, state, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isLoggedInNotifier,
          builder: (context, isLoggedIn, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Profile App',
              theme: state.mode == AppThemeMode.dark
                  ? ThemeData.dark()
                  : ThemeData.light(),
              home: isLoggedIn
                  ? ProfilePage(
                      onLogout: () {
                        widget.prefs.setBool('isLoggedIn', false);
                        _updateLoggedInStatus(false);
                      },
                    )
                  : LoginPage(
                      onLogin: () {
                        widget.prefs.setBool('isLoggedIn', true);
                        _updateLoggedInStatus(true);
                      },
                    ),
            );
          },
        );
      }),
    );
  }
}
