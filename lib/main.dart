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
        primarySwatch: MaterialColor(0xFF01BEFD, {
          50: Color(0xFFE1F7FE),
          100: Color(0xFFB3ECFD),
          200: Color(0xFF80E1FC),
          300: Color(0xFF4DD6FB),
          400: Color(0xFF26CDFB),
          500: Color(0xFF00BFFD), // valeur principale
          600: Color(0xFF01A8E3),
          700: Color(0xFF018FC7),
          800: Color(0xFF0176AB),
          900: Color(0xFF01578A),
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white, // Couleur de fond de l'application
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF00BFFD), // Couleur des icônes sélectionnées
          unselectedItemColor: Colors.grey, // Couleur des icônes non sélectionnées
          backgroundColor: Colors.white, // Couleur de fond du menu
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF00BFFD), // Couleur du texte des boutons interactifs
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF00BFFD), // Couleur du texte des boutons interactifs
          ),
        ),
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

