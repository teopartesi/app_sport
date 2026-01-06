import '../models/exercise_performance.dart';

class PerformanceRepository {
  final Map<String, ExercisePerformance> _performances = {};

  ExercisePerformance? getPerformance(String key) {
    return _performances[key];
  }

  void savePerformance(String key, ExercisePerformance performance) {
    _performances[key] = performance;
  }
}
