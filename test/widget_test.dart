import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_book/main.dart';

void main() {
  testWidgets('Онбординг → категории → рецепт → избранное', (tester) async {
    await tester.pumpWidget(const RecipeBookApp());
    expect(find.text('Готовьте с удовольствием'), findsOneWidget);

    await tester.tap(find.text('Пропустить'));
    await tester.pumpAndSettle();
    expect(find.text('Супы'), findsOneWidget);

    await tester.tap(find.text('Десерты'));
    await tester.pumpAndSettle();
    expect(find.text('Брауни'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.text('Брауни'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Ингредиенты'), findsOneWidget);

    await tester.tap(find.text('Тёмный шоколад — 200 г'));
    await tester.pump();
    expect(find.text('Ингредиенты (1/5)'), findsOneWidget);
  });
}
