import 'package:flutter/material.dart';
import '../models/exercise_structure.dart';
import 'exercise_list_page.dart'; // Nouvelle page pour afficher les exercices

class PerformancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performances")),
      body: ListView.builder(
        itemCount: muscleGroups.length,
        itemBuilder: (context, index) {
          final group = muscleGroups[index];

          return ListTile(
            title: Text(
              group.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.arrow_forward_ios), // Flèche à droite
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseListPage(muscleGroup: group),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
