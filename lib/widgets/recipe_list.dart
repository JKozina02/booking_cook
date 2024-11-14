import 'package:booking_cook/widgets/small_recipe_card.dart';
import 'package:flutter/material.dart';
import '../model/models.dart';

class RecipeList extends StatefulWidget {
  final void Function(Recipe) onRecipeTap; // Zmiana typu, aby akceptował Recipe

  const RecipeList({super.key, required this.onRecipeTap});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  void addRecipe(String name, List<String> ingredients, List<String> steps) {
    setState(() {
      myRecipes.add(Recipe(
        recipeName: name,
        recipeIngredients: ingredients,
        recipeSteps: steps,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 1,
      ),
      itemCount: myRecipes.length,
      itemBuilder: (context, index) {
        return SmallRecipeCard(
          recipe: myRecipes[index],
          onTap: () {
            widget.onRecipeTap(myRecipes[index]); // Przekazanie obiektu Recipe
          },
        );
      },
    );
  }
}