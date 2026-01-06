class Goal {
  String id;
  String exerciseName;
  String goalType; // "weight", "reps", "sessions", "bodyweight"
  double currentValue;
  double targetValue;
  DateTime startDate;
  DateTime targetDate;
  String description;
  bool isCompleted;

  Goal({
    required this.id,
    required this.exerciseName,
    required this.goalType,
    required this.currentValue,
    required this.targetValue,
    required this.startDate,
    required this.targetDate,
    required this.description,
    this.isCompleted = false,
  });

  double get progressPercentage {
    if (targetValue == 0) return 0;
    return (currentValue / targetValue * 100).clamp(0, 100);
  }

  int get daysRemaining {
    final now = DateTime.now();
    if (targetDate.isBefore(now)) return 0;
    return targetDate.difference(now).inDays;
  }

  String get progressText {
    switch (goalType) {
      case "weight":
        return "${currentValue.toInt()}kg / ${targetValue.toInt()}kg";
      case "reps":
        return "${currentValue.toInt()} / ${targetValue.toInt()} reps";
      case "sessions":
        return "${currentValue.toInt()} / ${targetValue.toInt()} séances";
      case "bodyweight":
        return "${currentValue.toStringAsFixed(1)}kg / ${targetValue.toStringAsFixed(1)}kg";
      default:
        return "${currentValue.toInt()} / ${targetValue.toInt()}";
    }
  }

  String get unitLabel {
    switch (goalType) {
      case "weight":
        return "kg";
      case "reps":
        return "répétitions";
      case "sessions":
        return "séances";
      case "bodyweight":
        return "kg";
      default:
        return "";
    }
  }
}