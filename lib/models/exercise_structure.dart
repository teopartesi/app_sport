class MuscleGroup {
  final String name;
  final List<Exercise> exercises;

  MuscleGroup({required this.name, required this.exercises});
}

class Exercise {
  final String name;

  Exercise({required this.name});
}

List<MuscleGroup> muscleGroups = [
  MuscleGroup(
    name: "Pectoraux",
    exercises: [
      Exercise(name: "Développé couché"),
      Exercise(name: "Écartés à la machine"),
      Exercise(name: "Pompes"),
    ],
  ),
  MuscleGroup(
    name: "Dos",
    exercises: [
      Exercise(name: "Tractions"),
      Exercise(name: "Rowing barre"),
      Exercise(name: "Tirage poitrine"),
    ],
  ),
  MuscleGroup(
    name: "Jambes",
    exercises: [
      Exercise(name: "Squat"),
      Exercise(name: "Presse à cuisses"),
      Exercise(name: "Extensions de jambes"),
    ],
  ),
  MuscleGroup(
    name: "Épaules",
    exercises: [
      Exercise(name: "Développé militaire"),
      Exercise(name: "Élévations latérales"),
      Exercise(name: "Élévations frontales"),
    ],
  ),
  // Add more muscle groups and exercises as needed
];

