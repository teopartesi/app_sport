import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../state/profile_state.dart';
import '../widgets/stats_card.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      if (!mounted) {
        return;
      }
      context.read<ProfileState>().updateImage(bytes);
    }
  }

  void _showPicker(BuildContext context, List<int> values, int selectedValue, Function(int) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: values.indexOf(selectedValue)),
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              onSelected(values[index]);
            },
            children: values.map((value) => Text(value.toString(), style: TextStyle(fontSize: 24))).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: profileState.imageBytes != null
                              ? MemoryImage(profileState.imageBytes!)
                              : null,
                          child: profileState.imageBytes == null
                              ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Changer la photo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informations personnelles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Âge
                      _buildInfoRow(
                        context,
                        "Âge",
                        "${profileState.selectedAge} ans",
                        Icons.calendar_today,
                        () => _showPicker(context, List.generate(81, (i) => i + 10), profileState.selectedAge, (val) {
                          context.read<ProfileState>().updateAge(val);
                        }),
                      ),
                      Divider(),
                      // Poids
                      _buildInfoRow(
                        context,
                        "Poids",
                        "${profileState.selectedWeight} kg",
                        Icons.monitor_weight_outlined,
                        () => _showPicker(context, List.generate(111, (i) => i + 40), profileState.selectedWeight, (val) {
                          context.read<ProfileState>().updateWeight(val);
                        }),
                      ),
                      Divider(),
                      // Taille
                      _buildInfoRow(
                        context,
                        "Taille",
                        "${profileState.selectedHeight} cm",
                        Icons.height,
                        () => _showPicker(context, List.generate(101, (i) => i + 120), profileState.selectedHeight, (val) {
                          context.read<ProfileState>().updateHeight(val);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Tableau de bord",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  StatsCard(
                    title: "IMC",
                    value: profileState.bmi.toStringAsFixed(1),
                    icon: Icons.monitor_weight,
                    color: profileState.bmiColor,
                  ),
                  StatsCard(
                    title: "Poids idéal",
                    value: "${profileState.idealWeight.toStringAsFixed(1)} kg",
                    icon: Icons.verified,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  StatsCard(
                    title: "Calories/jour",
                    value: "${profileState.calories.round()}",
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                  ),
                  StatsCard(
                    title: "Eau/jour",
                    value: "${profileState.waterIntake.round()} L",
                    icon: Icons.opacity,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Statistiques",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildStatsRow("IMC", profileState.bmi.toStringAsFixed(1), 
                          profileState.bmiColor),
                      SizedBox(height: 12),
                      _buildStatsRow("Poids idéal", "${profileState.idealWeight.toStringAsFixed(1)} kg", 
                          Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Ajouter ces méthodes à la classe _ProfilePageState:

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            value, 
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            )
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
