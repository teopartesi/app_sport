import 'package:flutter/foundation.dart';
import '../models/exercise_performance.dart';
import '../models/exercise_structure.dart';
import '../repositories/performance_repository.dart';
import '../services/performance_service.dart';

class PerformanceState extends ChangeNotifier {
  PerformanceState({
    PerformanceRepository? repository,
    PerformanceService? service,
  })  : _repository = repository ?? PerformanceRepository(),
        _service = service ?? PerformanceService();

  final PerformanceRepository _repository;
  final PerformanceService _service;

  Map<String, String> get muscleGroupImages => _service.muscleGroupImages;

  ExercisePerformance? getPerformance(MuscleGroup group, Exercise exercise) {
    return _repository.getPerformance(
      _service.performanceKey(group.name, exercise.name),
    );
  }

  void savePerformance(
    MuscleGroup group,
    Exercise exercise,
    ExercisePerformance performance,
  ) {
    _repository.savePerformance(
      _service.performanceKey(group.name, exercise.name),
      performance,
    );
    notifyListeners();
  }
}
