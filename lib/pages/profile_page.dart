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
      appBar: AppBar(title: Text("Profil")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.camera_alt, size: 40, color: Colors.white) : null,
              ),
            ),
            SizedBox(height: 20),
            
            // Sélecteur d'âge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Âge", style: TextStyle(fontSize: 20)),
                TextButton(
                  onPressed: () => _showPicker(context, List.generate(81, (i) => i + 10), selectedAge, (val) {
                    setState(() => selectedAge = val);
                  }),
                  child: Text("$selectedAge ans", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),

            // Sélecteur de poids
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Poids", style: TextStyle(fontSize: 20)),
                TextButton(
                  onPressed: () => _showPicker(context, List.generate(111, (i) => i + 40), selectedWeight, (val) {
                    setState(() => selectedWeight = val);
                  }),
                  child: Text("$selectedWeight kg", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),

            // Sélecteur de taille
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Taille", style: TextStyle(fontSize: 20)),
                TextButton(
                  onPressed: () => _showPicker(context, List.generate(101, (i) => i + 120), selectedHeight, (val) {
                    setState(() => selectedHeight = val);
                  }),
                  child: Text("$selectedHeight cm", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
