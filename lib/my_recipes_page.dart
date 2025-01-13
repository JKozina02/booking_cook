import 'package:flutter/material.dart';
import 'models.dart';

class MyRecipesPage extends StatelessWidget {
  const MyRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        final recipe = recipeList[index];
        return ListTile(
          title: Text(recipe.recipeName),
          subtitle: Text(recipe.recipeIngredients.join(', ')),
          onTap: () {
            // Możesz dodać tutaj logikę do wyświetlania szczegółów przepisu
          },
        );
      },
    );
  }
}