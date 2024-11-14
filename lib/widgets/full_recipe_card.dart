import 'package:flutter/material.dart';

import '../model/models.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  // Konstruktor przyjmujący obiekt Recipe
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 600,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.recipeName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Składniki:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                  ...recipe.recipeIngredients.map((ingredient) => Text('- $ingredient')),
                const SizedBox(height: 16),
                const Text(
                  'Kroki:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),
                ...recipe.recipeSteps.map((step) => Text('- $step')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}