import '../models/goal.dart';

class GoalService {
  void updateGoalProgress(List<Goal> goals, String goalId, double newValue) {
    final goalIndex = goals.indexWhere((goal) => goal.id == goalId);
    if (goalIndex == -1) {
      return;
    }
    final goal = goals[goalIndex];
    goal.currentValue = newValue;
    goal.isCompleted = newValue >= goal.targetValue;
  }

  Map<String, int> updateWeeklyTargets({
    required Map<String, int> weeklyStats,
    required int sessionsTarget,
    required int exercisesTarget,
    required int minutesTarget,
  }) {
    return {
      ...weeklyStats,
      "targetSessions": sessionsTarget < 1 ? 1 : sessionsTarget,
      "targetExercises": exercisesTarget < 1 ? 1 : exercisesTarget,
      "targetMinutes": minutesTarget < 1 ? 1 : minutesTarget,
    };
  }
}
