import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/goal.dart';
import '../state/goals_state.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  void _updateGoalProgress(String goalId, double newValue) {
    context.read<GoalsState>().updateGoalProgress(goalId, newValue);
  }

  void _deleteGoal(String goalId) {
    context.read<GoalsState>().deleteGoal(goalId);
  }

  @override
  Widget build(BuildContext context) {
    final goalsState = context.watch<GoalsState>();
    final goals = goalsState.goals;
    final weeklyStats = goalsState.weeklyStats;
    return Scaffold(
      appBar: AppBar(
        title: Text("Objectifs", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section progression hebdomadaire
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progression hebdomadaire",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProgressIndicator(
                        "Séances", 
                        weeklyStats["sessions"]!, 
                        weeklyStats["targetSessions"]!
                      ),
                      _buildProgressIndicator(
                        "Exercices", 
                        weeklyStats["exercises"]!, 
                        weeklyStats["targetExercises"]!
                      ),
                      _buildProgressIndicator(
                        "Minutes", 
                        weeklyStats["minutes"]!, 
                        weeklyStats["targetMinutes"]!
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showEditWeeklyGoalsDialog(),
                    icon: Icon(Icons.edit),
                    label: Text("Modifier objectifs hebdomadaires"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Section objectifs personnels
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mes objectifs",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),/*
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddGoalPage(onAddGoal: _addGoal),
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text("Ajouter"),
                      ),*/
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  if (goals.isEmpty)
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Aucun objectif défini",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Définissez vos premiers objectifs pour suivre votre progression",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: goals.length,
                      itemBuilder: (context, index) {
                        return _buildGoalCard(goals[index]);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, int current, int target) {
    final int safeTarget = target <= 0 ? 1 : target;
    final double progress = (current / safeTarget).clamp(0, 1);
    
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 8,
              ),
            ),
            Text(
              "$current/$target",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard(Goal goal) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.exerciseName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        goal.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showUpdateProgressDialog(goal);
                    } else if (value == 'delete') {
                      _deleteGoal(goal.id);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Mettre à jour'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Supprimer', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Barre de progression
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: goal.progressPercentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      goal.isCompleted ? Colors.green : Theme.of(context).colorScheme.primary,
                    ),
                    minHeight: 8,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "${goal.progressPercentage.toInt()}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: goal.isCompleted ? Colors.green : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progression",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      goal.progressText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Échéance",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      goal.daysRemaining > 0 
                          ? "${goal.daysRemaining} jours restants"
                          : "Échéance dépassée",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: goal.daysRemaining > 0 ? Colors.orange : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            if (goal.isCompleted)
              Container(
                margin: EdgeInsets.only(top: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text(
                      "Objectif atteint !",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showUpdateProgressDialog(Goal goal) {
    TextEditingController controller = TextEditingController(
      text: goal.currentValue.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Mettre à jour la progression"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${goal.exerciseName} - ${goal.description}"),
              SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "Valeur actuelle (${goal.unitLabel})",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                double newValue = double.tryParse(controller.text) ?? goal.currentValue;
                _updateGoalProgress(goal.id, newValue);
                Navigator.pop(context);
                
                if (newValue >= goal.targetValue) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("🎉 Félicitations ! Objectif atteint !"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text("Mettre à jour"),
            ),
          ],
        );
      },
    );
  }

  void _showEditWeeklyGoalsDialog() {
    final weeklyStats = context.read<GoalsState>().weeklyStats;
    Map<String, TextEditingController> controllers = {
      'sessions': TextEditingController(text: weeklyStats["targetSessions"].toString()),
      'exercises': TextEditingController(text: weeklyStats["targetExercises"].toString()),
      'minutes': TextEditingController(text: weeklyStats["targetMinutes"].toString()),
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Objectifs hebdomadaires"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllers['sessions'],
                decoration: InputDecoration(
                  labelText: "Séances par semaine",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: controllers['exercises'],
                decoration: InputDecoration(
                  labelText: "Exercices par semaine",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              TextField(
                controller: controllers['minutes'],
                decoration: InputDecoration(
                  labelText: "Minutes par semaine",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                final sessionsTarget = int.tryParse(controllers['sessions']!.text) ?? 5;
                final exercisesTarget = int.tryParse(controllers['exercises']!.text) ?? 25;
                final minutesTarget = int.tryParse(controllers['minutes']!.text) ?? 200;
                context.read<GoalsState>().updateWeeklyTargets(
                      sessionsTarget: sessionsTarget,
                      exercisesTarget: exercisesTarget,
                      minutesTarget: minutesTarget,
                    );
                Navigator.pop(context);
              },
              child: Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }
}
