import 'package:flutter/foundation.dart';
import '../models/workout_session.dart';
import '../services/active_workout_service.dart';

class ActiveWorkoutState extends ChangeNotifier {
  ActiveWorkoutState({
    required WorkoutSession workout,
    ActiveWorkoutService? service,
  })  : _workout = workout,
        _service = service ?? ActiveWorkoutService();

  final WorkoutSession _workout;
  final ActiveWorkoutService _service;
  int _currentExerciseIndex = 0;

  WorkoutSession get workout => _workout;
  int get currentExerciseIndex => _currentExerciseIndex;

  String get currentExercise {
    if (_workout.exercises.isEmpty) {
      return '';
    }
    return _workout.exercises[_currentExerciseIndex];
  }

  bool get isLastExercise {
    return _service.isLastExercise(
      _currentExerciseIndex,
      _workout.exercises.length,
    );
  }

  double get progress {
    return _service.progress(
      _currentExerciseIndex,
      _workout.exercises.length,
    );
  }

  int get progressPercent {
    return _service.progressPercent(
      _currentExerciseIndex,
      _workout.exercises.length,
    );
  }

  bool advanceExercise() {
    final nextIndex = _service.nextIndex(
      _currentExerciseIndex,
      _workout.exercises.length,
    );
    if (nextIndex == _currentExerciseIndex) {
      return false;
    }
    _currentExerciseIndex = nextIndex;
    notifyListeners();
    return true;
  }
}
