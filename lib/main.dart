import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'pages/performance_page.dart';
import 'pages/workout_planner_page.dart';

void main() {
  runApp(SportApp());
}

class SportApp extends StatefulWidget {
  @override
  _SportAppState createState() => _SportAppState();
}

class _SportAppState extends State<SportApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    PerformancePage(),
    WorkoutPlannerPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Performances"),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "Planification"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
        ),
      ),
    );
  }
}

