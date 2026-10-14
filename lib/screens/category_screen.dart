import 'package:flutter/material.dart';

import '../data/recipes.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';

/// Список рецептов выбранной категории (ListView).
class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final items = recipes.where((r) => r.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, i) => RecipeCard(recipe: items[i]),
      ),
    );
  }
}
