import 'dart:math';
import 'package:flutter_application_1/listeners/value_listener.dart';
import 'package:flutter_application_1/utils/themeapp.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      floatingActionButton: FloatingActionButton(onPressed: (){}),
      
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: ThemeApp.WarmTheme().colorScheme.surface,
      ),
      body: Center(
        child: Text(
          'Bienvenido al Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) { 
          setState(() => _currentIndex = i);
          if (i==3){
            ValueListener.isDarkMode.value = !ValueListener.isDarkMode.value;
          }
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: ValueListenableBuilder(
              valueListenable: ValueListener.isDarkMode,
              builder: (context, isDarkMode, _) {
                return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
              }
            ),
            title: Text("Theme"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      
    );
  }
}