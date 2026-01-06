class PerformanceService {
  final Map<String, String> muscleGroupImages = const {
    "Pectoraux": 'assets/icon/chest.png',
    "Dos": 'assets/icon/back.png',
    "Épaules": 'assets/icon/shoulders.png',
    "Biceps": 'assets/icon/biceps.png',
    "Triceps": 'assets/icon/triceps.png',
    "Jambes": 'assets/icon/legs.png',
    "Abdominaux": 'assets/icon/abdos.png',
  };

  String performanceKey(String muscleGroupName, String exerciseName) {
    return "$muscleGroupName::$exerciseName";
  }
}
