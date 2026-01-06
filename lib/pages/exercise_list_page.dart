import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exercise_structure.dart';
import '../state/performance_state.dart';
import 'edit_performance_page.dart'; 

class ExerciseListPage extends StatefulWidget {
  final MuscleGroup muscleGroup;

  ExerciseListPage({required this.muscleGroup});

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  void _editPerformance(BuildContext context, Exercise exercise) {
    final performanceState = context.read<PerformanceState>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPerformancePage(
          exercise: exercise,
          initialPerformance: performanceState.getPerformance(
            widget.muscleGroup,
            exercise,
          ),
          onSave: (performance) {
            performanceState.savePerformance(
              widget.muscleGroup,
              exercise,
              performance,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final performanceState = context.watch<PerformanceState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.muscleGroup.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: widget.muscleGroup.categories.length,
        itemBuilder: (context, categoryIndex) {
          final category = widget.muscleGroup.categories[categoryIndex];

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              title: Text(
                category.categoryName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: category.exercises.map((exercise) {
                final lastPerformance = performanceState.getPerformance(
                  widget.muscleGroup,
                  exercise,
                );

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      exercise.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: lastPerformance != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.fitness_center, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    "Équipement: ${lastPerformance.equipment}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              ...lastPerformance.sets.map((set) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.done, size: 14, color: Theme.of(context).colorScheme.primary),
                                      SizedBox(width: 4),
                                      Text(
                                        "${set.weight} kg × ${set.reps} reps",
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          )
                        : Text("Aucune performance enregistrée"),
                    trailing: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    onTap: () => _editPerformance(context, exercise),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
