import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}

class Recipe {
  final String id;
  final String categoryId;
  final String title;
  final String image;
  final int minutes;
  final int servings;
  final String difficulty;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.image,
    required this.minutes,
    required this.servings,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
  });
}
