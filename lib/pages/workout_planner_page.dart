import 'package:flutter/material.dart';

class WorkoutPlannerPage extends StatefulWidget {
  @override
  _WorkoutPlannerPageState createState() => _WorkoutPlannerPageState();
}

class _WorkoutPlannerPageState extends State<WorkoutPlannerPage> {
  List<String> availableExercises = ["Bench Press", "Squat", "Deadlift", "Pull-Ups", "Dips"];
  List<String> selectedExercises = [];

  TextEditingController workoutNameController = TextEditingController();

  void addWorkout() {
    if (workoutNameController.text.isNotEmpty && selectedExercises.isNotEmpty) {
      print("Séance enregistrée: ${workoutNameController.text} avec ${selectedExercises.join(', ')}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Séance '${workoutNameController.text}' enregistrée !")),
      );
      workoutNameController.clear();
      setState(() {
        selectedExercises.clear();
      });
    }
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
            )
          ],
        ),
      ),
    );
  }
}
