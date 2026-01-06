// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agys/main.dart';

void main() {
  testWidgets('Test du rendu de l\'application', (WidgetTester tester) async {
    await tester.pumpWidget(SportApp()); // Assure-toi que c'est bien SportApp() le widget principal

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text("Performances"), findsOneWidget);
    expect(find.text("Planification"), findsOneWidget);
    expect(find.text("Profil"), findsOneWidget);
  });
}
