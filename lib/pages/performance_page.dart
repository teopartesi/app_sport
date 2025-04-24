import 'package:flutter/material.dart';
import '../models/exercise_structure.dart';
import 'exercise_list_page.dart';

class PerformancePage extends StatelessWidget {
  // Map associant chaque groupe musculaire à son image
  final Map<String, String> muscleGroupImages = {
    "Pectoraux": 'assets/icon/chest.png',
    "Dos": 'assets/icon/back.png',
    "Épaules": 'assets/icon/shoulders.png',
    "Biceps": 'assets/icon/biceps.png',
    "Triceps": 'assets/icon/triceps.png',
    "Jambes": 'assets/icon/legs.png',
    "Abdominaux": 'assets/icon/abdos.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performances")),
      body: ListView.builder(
        itemCount: muscleGroups.length,
        itemBuilder: (context, index) {
          final group = muscleGroups[index];
          final imagePath = muscleGroupImages[group.name];

          return ListTile(
            leading: imagePath != null
                ? Image.asset(
                    imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  )
                : Icon(
                    Icons.help_outline,
                    size: 50,
                    color: const Color.fromARGB(255, 0, 191, 255),
                  ),
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
