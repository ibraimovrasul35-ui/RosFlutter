import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/recipe.dart';
import '../screens/recipe_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final favorite = state.isFavorite(recipe.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RecipeScreen.routeName, arguments: recipe),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: recipe.id,
                  child: Image.asset(recipe.image, height: 180, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                      onPressed: () => state.toggleFavorite(recipe.id),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _Info(icon: Icons.schedule, text: '${recipe.minutes} мин'),
                      _Info(icon: Icons.people, text: '${recipe.servings} порц.'),
                      _Info(icon: Icons.bar_chart, text: recipe.difficulty),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Info({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
