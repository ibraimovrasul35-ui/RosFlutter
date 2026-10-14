import 'package:flutter/material.dart';

import '../app_state.dart';
import '../data/recipes.dart';
import '../widgets/recipe_card.dart';
import 'category_screen.dart';

/// Главный экран: категории (GridView) и избранное, переключение через нижнюю навигацию.
class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tab == 0 ? 'RosFlutter' : 'Избранное'),
        actions: [
          IconButton(
            tooltip: 'Сменить тему',
            icon: Icon(state.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: state.toggleTheme,
          ),
        ],
      ),
      body: _tab == 0 ? const _CategoriesGrid() : const _FavoritesList(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Категории'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Избранное'),
        ],
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, i) {
        final category = categories[i];
        final count = recipes.where((r) => r.categoryId == category.id).length;
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [category.color.withValues(alpha: 0.7), category.color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(category.icon, size: 40, color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    Text('Рецептов: $count', style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FavoritesList extends StatelessWidget {
  const _FavoritesList();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final favorites = recipes.where((r) => state.isFavorite(r.id)).toList();

    if (favorites.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 12),
            const Text('Здесь появятся избранные рецепты', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, i) => RecipeCard(recipe: favorites[i]),
    );
  }
}
