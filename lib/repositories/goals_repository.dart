import '../models/goal.dart';

class GoalsRepository {
  final List<Goal> _goals = [
    Goal(
      id: "1",
      exerciseName: "Développé couché",
      goalType: "weight",
      currentValue: 80,
      targetValue: 100,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      targetDate: DateTime.now().add(const Duration(days: 60)),
      description: "Atteindre 100kg au développé couché",
    ),
    Goal(
      id: "2",
      exerciseName: "Séances hebdomadaires",
      goalType: "sessions",
      currentValue: 3,
      targetValue: 5,
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      targetDate: DateTime.now().add(const Duration(days: 21)),
      description: "5 séances par semaine",
    ),
  ];

  Map<String, int> _weeklyStats = {
    "sessions": 3,
    "targetSessions": 5,
    "exercises": 15,
    "targetExercises": 25,
    "minutes": 120,
    "targetMinutes": 200,
  };

  List<Goal> get goals => _goals;
  Map<String, int> get weeklyStats => _weeklyStats;

  void deleteGoal(String goalId) {
    _goals.removeWhere((goal) => goal.id == goalId);
  }

  void updateWeeklyStats(Map<String, int> updated) {
    _weeklyStats = updated;
  }
}
