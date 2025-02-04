class MuscleGroup {
  final String name;
  final List<ExerciseCategory> categories;

  MuscleGroup({required this.name, required this.categories});
}

class ExerciseCategory {
  final String categoryName;
  final List<Exercise> exercises;

  ExerciseCategory({required this.categoryName, required this.exercises});
}

class Exercise {
  final String name;
  final List<String> equipmentTypes; // Types d'équipements possibles

  Exercise({required this.name, required this.equipmentTypes});
}

List<MuscleGroup> muscleGroups = [
  MuscleGroup(
    name: "Pectoraux",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Développé couché", equipmentTypes: ["Barre", "Haltères", "Machine"]),
          Exercise(name: "Développé incliné", equipmentTypes: ["Barre", "Haltères", "Machine"]),
          Exercise(name: "Développé décliné", equipmentTypes: ["Barre", "Haltères", "Machine"]),
          Exercise(name: "Pompes", equipmentTypes: ["Classiques", "Inclinées", "Déclinées"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Écarté couché", equipmentTypes: ["Haltères", "Poulie"]),
          Exercise(name: "Écarté incliné", equipmentTypes: ["Haltères", "Poulie"]),
          Exercise(name: "Pull-over", equipmentTypes: ["Haltères", "Poulie"]),
          Exercise(name: "Dips prise large", equipmentTypes: ["Poids du corps"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Dos",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Tractions", equipmentTypes: ["Pronation", "Supination", "Prise neutre"]),
          Exercise(name: "Rowing", equipmentTypes: ["Barre", "Haltères", "Poulie"]),
          Exercise(name: "Soulevé de terre", equipmentTypes: ["Barre", "Haltères"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Pullover à la poulie", equipmentTypes: ["Poulie"]),
          Exercise(name: "Facepull", equipmentTypes: ["Corde"]),
          Exercise(name: "Tirage horizontal à la poulie", equipmentTypes: ["Poulie"]),
          Exercise(name: "Tirage vertical", equipmentTypes: ["Large", "Serré", "Prise neutre"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Épaules",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Développé militaire", equipmentTypes: ["Barre", "Haltères"]),
          Exercise(name: "Développé Arnold", equipmentTypes: ["Haltères"]),
          Exercise(name: "Développé à la machine guidée", equipmentTypes: ["Machine"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Élévations latérales", equipmentTypes: ["Haltères", "Poulie"]),
          Exercise(name: "Élévations frontales", equipmentTypes: ["Haltères", "Poulie"]),
          Exercise(name: "Oiseau", equipmentTypes: ["Haltères", "Poulie", "Machine"]),
          Exercise(name: "Facepull", equipmentTypes: ["Corde"]),
          Exercise(name: "Shrugs", equipmentTypes: ["Haltères", "Barre"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Biceps",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Curl barre", equipmentTypes: ["EZ", "Droite"]),
          Exercise(name: "Curl haltères", equipmentTypes: ["Supination", "Marteau"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Curl incliné", equipmentTypes: ["Haltères"]),
          Exercise(name: "Curl concentré", equipmentTypes: ["Haltères"]),
          Exercise(name: "Curl à la poulie", equipmentTypes: ["Poulie"]),
          Exercise(name: "Curl prise marteau", equipmentTypes: ["Haltères", "Corde"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Triceps",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Dips prise serrée", equipmentTypes: ["Poids du corps"]),
          Exercise(name: "Développé couché prise serrée", equipmentTypes: ["Barre"]),
          Exercise(name: "Développé militaire prise serrée", equipmentTypes: ["Barre"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Extensions à la poulie", equipmentTypes: ["Barre", "Corde"]),
          Exercise(name: "Extensions haltères derrière la tête", equipmentTypes: ["Haltères"]),
          Exercise(name: "Kickback haltères", equipmentTypes: ["Haltères"]),
          Exercise(name: "Skull crushers", equipmentTypes: ["Barre EZ"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Jambes",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices de base",
        exercises: [
          Exercise(name: "Squat", equipmentTypes: ["Classique", "Avant", "Sumo"]),
          Exercise(name: "Presse à jambes", equipmentTypes: ["Machine"]),
          Exercise(name: "Soulevé de terre jambes tendues", equipmentTypes: ["Barre", "Haltères"]),
          Exercise(name: "Fentes", equipmentTypes: ["Classiques", "Marchées", "Bulgares"]),
        ],
      ),
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Extension des jambes", equipmentTypes: ["Machine"]),
          Exercise(name: "Curl allongé ou assis", equipmentTypes: ["Machine"]),
          Exercise(name: "Élévations mollets", equipmentTypes: ["Assis", "Debout", "Presse"]),
        ],
      ),
    ],
  ),
  MuscleGroup(
    name: "Abdominaux",
    categories: [
      ExerciseCategory(
        categoryName: "Exercices d’isolation",
        exercises: [
          Exercise(name: "Crunch au sol", equipmentTypes: ["Poids du corps"]),
          Exercise(name: "Crunch à la poulie", equipmentTypes: ["Poulie"]),
          Exercise(name: "Relevé de jambes suspendu", equipmentTypes: ["Barre de traction"]),
          Exercise(name: "Gainage", equipmentTypes: ["Statique", "Dynamique"]),
          Exercise(name: "Russian twist", equipmentTypes: ["Poids", "Médecine Ball"]),
          Exercise(name: "Roue abdominale", equipmentTypes: ["Roue"]),
        ],
      ),
    ],
  ),
];
