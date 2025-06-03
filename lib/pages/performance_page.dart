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
      appBar: AppBar(
        title: Text("Performances", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // Titre de section
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 8),
                Text(
                  "Groupes musculaires",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Liste des groupes musculaires (existante)
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final group = muscleGroups[index];
                final imagePath = muscleGroupImages[group.name];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseListPage(muscleGroup: group),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imagePath != null
                            ? Image.asset(
                                imagePath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              )
                            : Icon(
                                Icons.fitness_center,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        SizedBox(height: 12),
                        Text(
                          group.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
