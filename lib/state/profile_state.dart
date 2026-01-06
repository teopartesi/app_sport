import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class ProfileState extends ChangeNotifier {
  ProfileState({ProfileService? service})
      : _service = service ?? ProfileService();

  final ProfileService _service;

  Uint8List? _imageBytes;
  int _selectedAge = 25;
  int _selectedWeight = 70;
  int _selectedHeight = 170;

  Uint8List? get imageBytes => _imageBytes;
  int get selectedAge => _selectedAge;
  int get selectedWeight => _selectedWeight;
  int get selectedHeight => _selectedHeight;

  void updateImage(Uint8List bytes) {
    _imageBytes = bytes;
    notifyListeners();
  }

  void updateAge(int age) {
    _selectedAge = age;
    notifyListeners();
  }

  void updateWeight(int weight) {
    _selectedWeight = weight;
    notifyListeners();
  }

  void updateHeight(int height) {
    _selectedHeight = height;
    notifyListeners();
  }

  double get bmi {
    return _service.calculateBMI(
      weight: _selectedWeight,
      height: _selectedHeight,
    );
  }

  double get idealWeight {
    return _service.calculateIdealWeight(height: _selectedHeight);
  }

  double get calories {
    return _service.calculateCalories(
      weight: _selectedWeight,
      height: _selectedHeight,
      age: _selectedAge,
    );
  }

  double get waterIntake {
    return _service.calculateWaterIntake(weight: _selectedWeight);
  }

  Color get bmiColor {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
}
