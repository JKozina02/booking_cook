import 'package:flutter/material.dart';

import '../model/models.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  // Konstruktor przyjmujący obiekt Recipe
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wyświetlanie nazwy przepisu
            Text(
              recipe.recipeName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Wyświetlanie sekcji Składniki
            const Text(
              'Składniki:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),
            ...recipe.recipeIngredients.map((ingredient) => Text('- $ingredient')),

            const SizedBox(height: 16),

            // Wyświetlanie sekcji Kroki
            const Text(
              'Kroki:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),
            ...recipe.recipeSteps.map((step) => Text('- $step')),
          ],
        ),
      ),
    );
  }
}