import 'package:flutter/material.dart';
import '../models/workout_session.dart';
import 'active_workout_page.dart';

class WorkoutPlannerPage extends StatefulWidget {
  @override
  _WorkoutPlannerPageState createState() => _WorkoutPlannerPageState();
}

class _WorkoutPlannerPageState extends State<WorkoutPlannerPage> {
  List<String> availableExercises = [
    "Bench Press", "Squat", "Deadlift", "Pull-Ups", "Dips",
    "Shoulder Press", "Barbell Rows", "Leg Press", "Lunges",
    "Bicep Curls", "Tricep Extensions", "Calf Raises", "Plank",
    "Russian Twists", "Lat Pulldowns", "Leg Curls", "Leg Extensions"
  ];
  List<WorkoutSession> savedWorkouts = [];

  Widget _buildSelectExercisesDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    List<String> filteredExercises = List.from(availableExercises);
    List<String> selectedExercises = [];

    return StatefulBuilder(
      builder: (context, setState) {
        void filterExercises(String query) {
          setState(() {
            filteredExercises = availableExercises
                .where((exercise) =>
                    exercise.toLowerCase().contains(query.toLowerCase()))
                .toList();
          });
        }

        return AlertDialog(
          title: Text("Sélectionner des exercices"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Rechercher un exercice",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: filterExercises,
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      String exercise = filteredExercises[index];
                      bool isSelected = selectedExercises.contains(exercise);
                      return CheckboxListTile(
                        title: Text(exercise),
                        value: isSelected,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              selectedExercises.add(exercise);
                            } else {
                              selectedExercises.remove(exercise);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedExercises.isNotEmpty) {
                  Navigator.pop(context);
                  _showNameWorkoutDialog(context, selectedExercises);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez sélectionner au moins un exercice")),
                  );
                }
              },
              child: Text("Suivant"),
            ),
          ],
        );
      },
    );
  }

  void _showNameWorkoutDialog(BuildContext context, List<String> selectedExercises) {
    TextEditingController workoutNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nom de la séance"),
          content: TextField(
            controller: workoutNameController,
            decoration: InputDecoration(
              labelText: "Nom de la séance",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                if (workoutNameController.text.isNotEmpty) {
                  setState(() {
                    savedWorkouts.add(WorkoutSession(
                      name: workoutNameController.text,
                      exercises: selectedExercises,
                    ));
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez entrer un nom pour la séance")),
                  );
                }
              },
              child: Text("Créer"),
            ),
          ],
        );
      },
    );
  }

  void launchWorkout(WorkoutSession workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiveWorkoutPage(workout: workout),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permet de redimensionner les widgets
      appBar: AppBar(
        title: Text("Planification", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Séances enregistrées",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: savedWorkouts.isEmpty
                  ? Center(
                      child: Text(
                        "Aucune séance enregistrée",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: savedWorkouts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: Text(
                                savedWorkouts[index].name[0].toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              savedWorkouts[index].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "${savedWorkouts[index].exercises.length} exercices",
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: ElevatedButton.icon(
                              icon: Icon(Icons.play_arrow),
                              label: Text("Démarrer"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => launchWorkout(savedWorkouts[index]),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return _buildSelectExercisesDialog(context);
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add),
      ),
    );
  }
}

