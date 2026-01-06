class ProfileService {
  double calculateCalories({
    required int weight,
    required int height,
    required int age,
  }) {
    return 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
  }

  double calculateWaterIntake({required int weight}) {
    return weight * 0.033;
  }

  double calculateBMI({
    required int weight,
    required int height,
  }) {
    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  double calculateIdealWeight({required int height}) {
    return (height - 100) - ((height - 150) / 4);
  }
}
