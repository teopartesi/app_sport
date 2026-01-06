import 'package:flutter/material.dart';
import '../models/exercise_performance.dart';
import '../models/exercise_structure.dart';

class EditPerformancePage extends StatefulWidget {
  final Exercise exercise;
  final ExercisePerformance? initialPerformance;
  final Function(ExercisePerformance) onSave;

  const EditPerformancePage({
    required this.exercise,
    this.initialPerformance,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  _EditPerformancePageState createState() => _EditPerformancePageState();
}

class _EditPerformancePageState extends State<EditPerformancePage> {
  late String selectedEquipment;
  late List<ExerciseSet> sets;

  @override
  void initState() {
    super.initState();
    selectedEquipment = widget.initialPerformance?.equipment ?? widget.exercise.equipmentTypes.first;
    sets = widget.initialPerformance?.sets != null && widget.initialPerformance!.sets.isNotEmpty
        ? List.from(widget.initialPerformance!.sets)
        : [ExerciseSet(weight: 0, reps: 0)];
  }

  void addSet() {
    setState(() {
      // Copier le dernier set pour faciliter l'entrée des données
      if (sets.isNotEmpty) {
        final lastSet = sets.last;
        sets.add(ExerciseSet(weight: lastSet.weight, reps: lastSet.reps));
      } else {
        sets.add(ExerciseSet(weight: 0, reps: 0));
      }
    });
  }

  void removeSet(int index) {
    setState(() {
      sets.removeAt(index);
    });
  }

  void savePerformance() {
    if (sets.isNotEmpty) {
      widget.onSave(
        ExercisePerformance(
          exerciseName: widget.exercise.name,
          equipment: selectedEquipment,
          sets: sets.where((set) => set.weight > 0 || set.reps > 0).toList(),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ajoutez au moins une série")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: savePerformance,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Équipement
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Équipement",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<String>(
                        value: selectedEquipment,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: widget.exercise.equipmentTypes.map((type) {
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
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Séries
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Séries",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Ajouter"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: addSet,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        // En-tête
                        Row(
                          children: [
                            SizedBox(width: 40),
                            Expanded(
                              child: Text(
                                "Poids (kg)",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Répétitions",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 40),
                          ],
                        ),
                        Divider(),
                        // Liste des séries
                        for (int i = 0; i < sets.length; i++)
                          Padding(
                            key: ObjectKey(sets[i]),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  child: Text(
                                    "#${i + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: TextFormField(
                                      initialValue: sets[i].weight.toString(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        setState(() {
                                          sets[i].weight = int.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: TextFormField(
                                      initialValue: sets[i].reps.toString(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      ),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        setState(() {
                                          sets[i].reps = int.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => removeSet(i),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Résumé
            if (sets.isNotEmpty)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Résumé",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSummaryItem(
                            "Total poids",
                            "${_calculateTotalWeight()} kg",
                            Icons.fitness_center,
                          ),
                          _buildSummaryItem(
                            "Total reps",
                            "${_calculateTotalReps()}",
                            Icons.repeat,
                          ),
                          _buildSummaryItem(
                            "Séries",
                            "${sets.length}",
                            Icons.playlist_add_check,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            onPressed: savePerformance,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text(
              "ENREGISTRER",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  int _calculateTotalWeight() {
    return sets.fold(0, (sum, set) => sum + (set.weight * set.reps));
  }

  int _calculateTotalReps() {
    return sets.fold(0, (sum, set) => sum + set.reps);
  }
}
