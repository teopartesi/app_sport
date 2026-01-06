import '../models/exercise_performance.dart';

class ExercisePerformanceService {
  List<ExerciseSet> buildInitialSets(ExercisePerformance? initialPerformance) {
    if (initialPerformance != null && initialPerformance.sets.isNotEmpty) {
      return List<ExerciseSet>.from(initialPerformance.sets);
    }
    return [ExerciseSet(weight: 0, reps: 0)];
  }

  List<ExerciseSet> addSet(List<ExerciseSet> sets) {
    final updated = List<ExerciseSet>.from(sets);
    if (updated.isNotEmpty) {
      final lastSet = updated.last;
      updated.add(ExerciseSet(weight: lastSet.weight, reps: lastSet.reps));
    } else {
      updated.add(ExerciseSet(weight: 0, reps: 0));
    }
    return updated;
  }

  List<ExerciseSet> removeSet(List<ExerciseSet> sets, int index) {
    final updated = List<ExerciseSet>.from(sets);
    updated.removeAt(index);
    return updated;
  }

  List<ExerciseSet> filterValidSets(List<ExerciseSet> sets) {
    return sets.where((set) => set.weight > 0 || set.reps > 0).toList();
  }

  int totalWeight(List<ExerciseSet> sets) {
    return sets.fold(0, (sum, set) => sum + (set.weight * set.reps));
  }

  int totalReps(List<ExerciseSet> sets) {
    return sets.fold(0, (sum, set) => sum + set.reps);
  }
}
