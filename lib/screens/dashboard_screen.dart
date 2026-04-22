
import 'package:flutter_application_1/listeners/value_listener.dart';

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
        // backgroundColor: ThemeApp.WarmTheme().colorScheme.surface,
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
          switch(i){
            case 0:
              Navigator.pushNamed(context, '/dashboard');
              break;
            case 1:
              Navigator.pushNamed(context, '/castList');
              break;
            case 2:
              Navigator.pushNamed(context, '/profesores');
              break;
            case 3:
              Navigator.pushNamed(context, '/series');
              break;
          }
          if (i==4){
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
            title: Text("Cast List"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("Profesores"),
            selectedColor: Colors.orange,
          ),

          SalomonBottomBarItem(
            icon: Icon(Icons.book_outlined),
            title: Text("Series"),
            selectedColor: const Color.fromARGB(255, 13, 255, 0),
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