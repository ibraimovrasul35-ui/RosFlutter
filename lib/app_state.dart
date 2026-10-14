import 'package:flutter/material.dart';

/// Общее состояние приложения: тема и избранные рецепты.
class AppState extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  final Set<String> favoriteIds = {};

  bool get isDark => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  bool isFavorite(String id) => favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (!favoriteIds.remove(id)) favoriteIds.add(id);
    notifyListeners();
  }
}

/// Передаёт [AppState] вниз по дереву виджетов.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
