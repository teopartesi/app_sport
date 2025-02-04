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
      appBar: AppBar(title: Text("Planification")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: workoutNameController,
              decoration: InputDecoration(labelText: "Nom de la séance"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: availableExercises.length,
                itemBuilder: (context, index) {
                  String exercise = availableExercises[index];
                  bool isSelected = selectedExercises.contains(exercise);
                  return CheckboxListTile(
                    title: Text(exercise),
                    value: isSelected,
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
            ElevatedButton(
              onPressed: addWorkout,
              child: Text("Enregistrer la séance"),
            ),
            SizedBox(height: 20),
            Text("Séances enregistrées", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: savedWorkouts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(savedWorkouts[index].name),
                    subtitle: Text(savedWorkouts[index].exercises.join(", ")),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () => launchWorkout(savedWorkouts[index]),
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

