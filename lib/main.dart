import 'package:flutter/material.dart';

import 'app_state.dart';
import 'models/recipe.dart';
import 'screens/category_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/recipe_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const RecipeBookApp());

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  final _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) => MaterialApp(
          title: 'RosFlutter',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _state.themeMode,
          initialRoute: OnboardingScreen.routeName,
          routes: {
            OnboardingScreen.routeName: (_) => const OnboardingScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
          },
          // Маршруты с аргументами
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case CategoryScreen.routeName:
                final category = settings.arguments as Category;
                return MaterialPageRoute(builder: (_) => CategoryScreen(category: category));
              case RecipeScreen.routeName:
                final recipe = settings.arguments as Recipe;
                return MaterialPageRoute(builder: (_) => RecipeScreen(recipe: recipe));
            }
            return null;
          },
        ),
      ),
    );
  }
}
