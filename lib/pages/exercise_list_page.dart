import 'package:flutter/material.dart';
import '../models/exercise_performance.dart';
import '../models/exercise_structure.dart';

class ExerciseListPage extends StatefulWidget {
  final MuscleGroup muscleGroup;

  ExerciseListPage({required this.muscleGroup});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  Map<String, ExercisePerformance> performances = {}; // Stocke les performances

  void _editPerformance(BuildContext context, Exercise exercise) {
    String selectedEquipment = exercise.equipmentTypes.first;
    List<ExerciseSet> sets = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Modifier ${exercise.name}"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sélection de l'équipement
                  DropdownButton<String>(
                    value: selectedEquipment,
                    items: exercise.equipmentTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedEquipment = value;
                        });
                      }
                    },
                  ),
                  
                  // Liste des séries
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: sets.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(labelText: "Poids (kg)"),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                sets[index].weight = int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(labelText: "Répétitions"),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                sets[index].reps = int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                sets.removeAt(index);
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),

                  // Bouton pour ajouter une série
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sets.add(ExerciseSet(weight: 0, reps: 0));
                      });
                    },
                    child: Text("Ajouter une série"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Annuler"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text("Enregistrer"),
                  onPressed: () {
                    if (sets.isNotEmpty) {
                      setState(() {
                        performances[exercise.name] = ExercisePerformance(
                          exerciseName: exercise.name,
                          equipment: selectedEquipment,
                          sets: sets,
                        );
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.muscleGroup.name)),
      body: ListView.builder(
        itemCount: widget.muscleGroup.categories.length,
        itemBuilder: (context, categoryIndex) {
          final category = widget.muscleGroup.categories[categoryIndex];

          return ExpansionTile(
            title: Text(category.categoryName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            children: category.exercises.map((exercise) {
              final lastPerformance = performances[exercise.name];

              return ListTile(
                title: Text(exercise.name, style: TextStyle(fontSize: 18)),
                subtitle: lastPerformance != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Équipement : ${lastPerformance.equipment}", style: TextStyle(color: Colors.grey)),
                          ...lastPerformance.sets.map((set) {
                            return Text("${set.weight} kg x ${set.reps} reps", style: TextStyle(color: Colors.grey));
                          }).toList(),
                        ],
                      )
                    : Text("Aucune performance enregistrée"),
                trailing: Icon(Icons.edit),
                onTap: () => _editPerformance(context, exercise),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
