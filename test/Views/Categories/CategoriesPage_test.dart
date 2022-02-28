import 'package:e_commers/Views/Categories/CategoriesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CategoriesPage ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoriesPage(),
    ));

    final categoriesTitleFinder = find.text('Categories');
    final arrowIconFinder = find.byIcon(Icons.arrow_back_ios_rounded);
    expect(categoriesTitleFinder, findsOneWidget);
    expect(arrowIconFinder, findsOneWidget);
  });

  testWidgets("Checking if Custom text is rendering or not", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CategoriesPage(),
    ));

    final iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);
  });
}
