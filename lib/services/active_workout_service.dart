class ActiveWorkoutService {
  bool isLastExercise(int index, int total) {
    if (total <= 0) {
      return true;
    }
    return index >= total - 1;
  }

  int nextIndex(int currentIndex, int total) {
    if (currentIndex < total - 1) {
      return currentIndex + 1;
    }
    return currentIndex;
  }

  double progress(int index, int total) {
    if (total <= 0) {
      return 0;
    }
    return (index + 1) / total;
  }

  int progressPercent(int index, int total) {
    return (progress(index, total) * 100).round();
  }
}
