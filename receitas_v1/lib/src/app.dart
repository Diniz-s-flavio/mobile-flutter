import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';


class RecipesApp extends StatelessWidget {
const RecipesApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas Favoritas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RecipeDetailScreen.routeName:
            final recipe = settings.arguments as Recipe;
            return MaterialPageRoute(
              builder: (_) => RecipeDetailScreen(recipe: recipe),
              settings: settings,
            );
          case SettingsScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
              settings: settings,
            );
          case AboutScreen.routeName:
            return MaterialPageRoute(
              builder: (_) => const AboutScreen(),
              settings: settings,
            );
        }
      return null;
      },
    );
  }
}