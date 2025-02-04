class ExerciseSet {
  int weight;
  int reps;

  ExerciseSet({required this.weight, required this.reps});
}

class ExercisePerformance {
  String exerciseName;
  String equipment;
  List<ExerciseSet> sets; // Liste des séries

  ExercisePerformance({
    required this.exerciseName,
    required this.equipment,
    required this.sets,
  });
}
