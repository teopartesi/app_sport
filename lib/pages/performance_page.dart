import 'package:flutter/material.dart';

class PerformancePage extends StatelessWidget {
  final List<Map<String, dynamic>> performances = [
    {"exercise": "Bench Press", "weight": 80, "reps": 1},
    {"exercise": "Squat", "weight": 100, "reps": 3},
    {"exercise": "Deadlift", "weight": 120, "reps": 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performances")),
      body: ListView.builder(
        itemCount: performances.length,
        itemBuilder: (context, index) {
          final performance = performances[index];
          return ListTile(
            title: Text(performance["exercise"]),
            subtitle: Text("${performance["weight"]} kg x ${performance["reps"]} reps"),
          );
        },
      ),
    );
  }
}
