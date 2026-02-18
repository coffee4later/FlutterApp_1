import 'package:flutter/material.dart';
import 'package:flutter_application_1/listeners/value_listener.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/utils/themeapp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ValueListener.isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          routes: {
            '/login': (context) => LoginScreen(),
            '/dashboard': (context) => DashboardScreen(),
          },
          theme: isDarkMode ? ThemeApp.WarmTheme() : ThemeData.light(),
        );
      }
    );
  }
}
