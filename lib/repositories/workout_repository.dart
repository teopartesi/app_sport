import '../models/workout_session.dart';

class WorkoutRepository {
  final List<WorkoutSession> _savedWorkouts = [];

  List<WorkoutSession> get savedWorkouts => List.unmodifiable(_savedWorkouts);

  void addWorkout(WorkoutSession workout) {
    _savedWorkouts.add(workout);
  }
}
