import 'package:flutter/material.dart';
import '../models/recipe.dart';


class RecipeDetailScreen extends StatelessWidget {
  static const routeName = '/recipe-detail';
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.shortDescription,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text('Ingredientes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((i) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• '),
                Expanded(child: Text(i)),
              ],
            )),
            const SizedBox(height: 16),
            Text('Modo de preparo', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(recipe.methodOfPreparation),
          ],
        ),
      ),
    );
  }
}