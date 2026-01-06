import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/profile_page.dart';
import 'pages/performance_page.dart';
import 'pages/workout_planner_page.dart';
import 'pages/goal_page.dart';
import 'state/goals_state.dart';
import 'state/performance_state.dart';
import 'state/profile_state.dart';
import 'state/workout_planner_state.dart';

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
    GoalsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PerformanceState()),
        ChangeNotifierProvider(create: (_) => WorkoutPlannerState()),
        ChangeNotifierProvider(create: (_) => GoalsState()),
        ChangeNotifierProvider(create: (_) => ProfileState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true, // Activer Material Design 3
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF00BFFD),
            brightness: Brightness.light,
          ),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Color(0xFF00BFFD),
            foregroundColor: Colors.white,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFF00BFFD),
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 8,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00BFFD),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
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
              BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Objectifs"), // Ajoute cet item
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
            ],
          ),
        ),
      ),
    );
  }
}

