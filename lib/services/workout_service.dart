import '../models/workout_session.dart';

class WorkoutService {
  List<String> get availableExercises => const [
        "Bench Press",
        "Squat",
        "Deadlift",
        "Pull-Ups",
        "Dips",
        "Shoulder Press",
        "Barbell Rows",
        "Leg Press",
        "Lunges",
        "Bicep Curls",
        "Tricep Extensions",
        "Calf Raises",
        "Plank",
        "Russian Twists",
        "Lat Pulldowns",
        "Leg Curls",
        "Leg Extensions",
      ];

  List<String> filterExercises(List<String> exercises, String query) {
    final lowerQuery = query.toLowerCase();
    return exercises
        .where((exercise) => exercise.toLowerCase().contains(lowerQuery))
        .toList();
  }

  WorkoutSession createSession(String name, List<String> exercises) {
    return WorkoutSession(name: name, exercises: exercises);
  }
}
