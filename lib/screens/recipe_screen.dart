import 'package:flutter/material.dart';

import '../app_state.dart';
import '../models/recipe.dart';

/// Подробный рецепт: фото, ингредиенты с отметками и шаги приготовления.
class RecipeScreen extends StatefulWidget {
  static const routeName = '/recipe';

  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final Set<int> _checked = {};

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final favorite = state.isFavorite(recipe.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => state.toggleFavorite(recipe.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title, style: const TextStyle(fontWeight: FontWeight.w800)),
              background: Hero(
                tag: recipe.id,
                child: Image.asset(recipe.image, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList.list(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(icon: Icons.schedule, label: 'Время', value: '${recipe.minutes} мин'),
                    _Stat(icon: Icons.people, label: 'Порции', value: '${recipe.servings}'),
                    _Stat(icon: Icons.bar_chart, label: 'Сложность', value: recipe.difficulty),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Ингредиенты (${_checked.length}/${recipe.ingredients.length})',
                    style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                for (var i = 0; i < recipe.ingredients.length; i++)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _checked.contains(i),
                    onChanged: (v) => setState(() => v! ? _checked.add(i) : _checked.remove(i)),
                    title: Text(
                      recipe.ingredients[i],
                      style: TextStyle(
                        decoration: _checked.contains(i) ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text('Приготовление', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                for (var i = 0; i < recipe.steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: theme.colorScheme.primary,
                          child: Text('${i + 1}',
                              style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(recipe.steps[i], style: theme.textTheme.bodyLarge)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _Stat({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.onPrimaryContainer),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.titleMedium),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
