import 'package:flutter/material.dart';
import '../models/workout_session.dart';

class ActiveWorkoutPage extends StatefulWidget {
  final WorkoutSession workout;

  ActiveWorkoutPage({required this.workout});

  @override
  _ActiveWorkoutPageState createState() => _ActiveWorkoutPageState();
}

class _ActiveWorkoutPageState extends State<ActiveWorkoutPage> {
  int currentExerciseIndex = 0;

  void nextExercise() {
    if (currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
      });
    } else {
      // Workout completed
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Séance terminée !")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.workout.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.workout.exercises[currentExerciseIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextExercise,
              child: Text("Exercice suivant"),
            ),
          ],
        ),
      ),
    );
  }
}

