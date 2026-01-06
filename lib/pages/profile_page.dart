import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image; // Stocke l’image de profil
  int selectedAge = 25;
  int selectedWeight = 70;
  int selectedHeight = 170;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  double _calculateCalories() {
    // Formule de Harris-Benedict simplifiée
    // Pour les hommes : MB = 66 + (13,7 × poids) + (5 × taille) - (6,8 × âge)
    // Ceci est une approximation
    return 66 + (13.7 * selectedWeight) + (5 * selectedHeight) - (6.8 * selectedAge);
  }

  double _calculateWaterIntake() {
    // Recommandation approximative: 0.033L par kg de poids corporel
    return selectedWeight * 0.033;
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
                          backgroundImage: _image != null ? FileImage(_image!) : null,
                          child: _image == null
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
                        "$selectedAge ans",
                        Icons.calendar_today,
                        () => _showPicker(context, List.generate(81, (i) => i + 10), selectedAge, (val) {
                          setState(() => selectedAge = val);
                        }),
                      ),
                      Divider(),
                      // Poids
                      _buildInfoRow(
                        context,
                        "Poids",
                        "$selectedWeight kg",
                        Icons.monitor_weight_outlined,
                        () => _showPicker(context, List.generate(111, (i) => i + 40), selectedWeight, (val) {
                          setState(() => selectedWeight = val);
                        }),
                      ),
                      Divider(),
                      // Taille
                      _buildInfoRow(
                        context,
                        "Taille",
                        "$selectedHeight cm",
                        Icons.height,
                        () => _showPicker(context, List.generate(101, (i) => i + 120), selectedHeight, (val) {
                          setState(() => selectedHeight = val);
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
                    value: _calculateBMI().toStringAsFixed(1),
                    icon: Icons.monitor_weight,
                    color: _getBMIColor(_calculateBMI()),
                  ),
                  StatsCard(
                    title: "Poids idéal",
                    value: "${_calculateIdealWeight().toStringAsFixed(1)} kg",
                    icon: Icons.verified,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  StatsCard(
                    title: "Calories/jour",
                    value: "${_calculateCalories().round()}",
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                  ),
                  StatsCard(
                    title: "Eau/jour",
                    value: "${_calculateWaterIntake().round()} L",
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
                      _buildStatsRow("IMC", _calculateBMI().toStringAsFixed(1), 
                          _getBMIColor(_calculateBMI())),
                      SizedBox(height: 12),
                      _buildStatsRow("Poids idéal", "${_calculateIdealWeight().toStringAsFixed(1)} kg", 
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

  double _calculateBMI() {
    // Hauteur en mètres
    double heightInMeters = selectedHeight / 100;
    return selectedWeight / (heightInMeters * heightInMeters);
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  double _calculateIdealWeight() {
    // Formule de Lorentz
    return (selectedHeight - 100) - ((selectedHeight - 150) / 4);
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
