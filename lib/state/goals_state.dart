import 'package:flutter/foundation.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';
import '../services/goal_service.dart';

class GoalsState extends ChangeNotifier {
  GoalsState({
    GoalsRepository? repository,
    GoalService? service,
  })  : _repository = repository ?? GoalsRepository(),
        _service = service ?? GoalService();

  final GoalsRepository _repository;
  final GoalService _service;

  List<Goal> get goals => List.unmodifiable(_repository.goals);
  Map<String, int> get weeklyStats => Map.unmodifiable(_repository.weeklyStats);

  void updateGoalProgress(String goalId, double newValue) {
    _service.updateGoalProgress(_repository.goals, goalId, newValue);
    notifyListeners();
  }

  void deleteGoal(String goalId) {
    _repository.deleteGoal(goalId);
    notifyListeners();
  }

  void updateWeeklyTargets({
    required int sessionsTarget,
    required int exercisesTarget,
    required int minutesTarget,
  }) {
    final updated = _service.updateWeeklyTargets(
      weeklyStats: _repository.weeklyStats,
      sessionsTarget: sessionsTarget,
      exercisesTarget: exercisesTarget,
      minutesTarget: minutesTarget,
    );
    _repository.updateWeeklyStats(updated);
    notifyListeners();
  }
}
