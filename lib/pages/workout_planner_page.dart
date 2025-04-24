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
  List<String> selectedExercises = [];
  List<WorkoutSession> savedWorkouts = [];

  TextEditingController workoutNameController = TextEditingController();

  void addWorkout() {
    if (workoutNameController.text.isNotEmpty && selectedExercises.isNotEmpty) {
      setState(() {
        savedWorkouts.add(WorkoutSession(
          name: workoutNameController.text,
          exercises: List.from(selectedExercises),
        ));
        workoutNameController.clear();
        selectedExercises.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Séance '${workoutNameController.text}' enregistrée !")),
      );
    }
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
      appBar: AppBar(
        title: Text("Planification"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Créer une nouvelle séance",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: workoutNameController,
                      decoration: InputDecoration(
                        labelText: "Nom de la séance",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Sélectionner des exercices:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListView.builder(
                  itemCount: availableExercises.length,
                  itemBuilder: (context, index) {
                    String exercise = availableExercises[index];
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
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: addWorkout,
                icon: Icon(Icons.save),
                label: Text("Enregistrer la séance"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Séances enregistrées",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 1,
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
                              savedWorkouts[index].exercises.length.toString() + 
                              " exercices",
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
    );
  }
}

