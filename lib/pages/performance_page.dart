import 'package:flutter/material.dart';
import '../models/exercise_performance.dart';
import '../models/exercise_structure.dart';

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  List<ExercisePerformance> performances = [];

  void _selectMuscleGroup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sélectionnez un groupe musculaire"),
          content: SingleChildScrollView(
            child: ListBody(
              children: muscleGroups.map((group) => 
                ListTile(
                  title: Text(group.name),
                  onTap: () {
                    Navigator.pop(context);
                    _selectExercise(context, group);
                  },
                )
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  void _selectExercise(BuildContext context, MuscleGroup muscleGroup) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sélectionnez un exercice"),
          content: SingleChildScrollView(
            child: ListBody(
              children: muscleGroup.exercises.map((exercise) => 
                ListTile(
                  title: Text(exercise.name),
                  onTap: () {
                    Navigator.pop(context);
                    _inputPerformance(context, exercise);
                  },
                )
              ).toList(),
            ),
          ),
        );
      },
    );
  }

  void _inputPerformance(BuildContext context, Exercise exercise) {
    int weight = 0;
    int reps = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Entrez votre performance pour ${exercise.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Poids (kg)"),
                keyboardType: TextInputType.number,
                onChanged: (value) => weight = int.tryParse(value) ?? 0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Répétitions"),
                keyboardType: TextInputType.number,
                onChanged: (value) => reps = int.tryParse(value) ?? 0,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Annuler"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Enregistrer"),
              onPressed: () {
                if (weight > 0 && reps > 0) {
                  setState(() {
                    performances.add(ExercisePerformance(
                      exerciseName: exercise.name,
                      weight: weight,
                      reps: reps,
                    ));
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Performances")),
      body: ListView.builder(
        itemCount: performances.length,
        itemBuilder: (context, index) {
          final performance = performances[index];
          return ListTile(
            title: Text(performance.exerciseName),
            subtitle: Text("${performance.weight} kg x ${performance.reps} reps"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectMuscleGroup(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

