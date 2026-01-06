import 'package:flutter/foundation.dart';
import '../models/workout_session.dart';
import '../repositories/workout_repository.dart';
import '../services/workout_service.dart';

class WorkoutPlannerState extends ChangeNotifier {
  WorkoutPlannerState({
    WorkoutRepository? repository,
    WorkoutService? service,
  })  : _repository = repository ?? WorkoutRepository(),
        _service = service ?? WorkoutService();

  final WorkoutRepository _repository;
  final WorkoutService _service;

  List<String> get availableExercises => _service.availableExercises;
  List<WorkoutSession> get savedWorkouts => _repository.savedWorkouts;

  List<String> filterExercises(String query) {
    return _service.filterExercises(availableExercises, query);
  }

  void addWorkout(String name, List<String> exercises) {
    _repository.addWorkout(_service.createSession(name, exercises));
    notifyListeners();
  }
}
