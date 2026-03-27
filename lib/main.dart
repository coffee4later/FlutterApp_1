import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/professors_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/listeners/value_listener.dart';
import 'package:flutter_application_1/screens/castList_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/utils/themeapp.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

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
            '/castList':(context) => CastlistScreen(),
            '/signup':(context) => SignUpScreen(),
            '/profesores':(context) => ProfessorsScreen(),
          },
          theme: isDarkMode ? ThemeApp.warmTheme() : ThemeData.light(),
        );
      }
    );
  }
}
