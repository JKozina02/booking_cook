import 'package:flutter/material.dart';
import '../model/models.dart';
import './recipe_card.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,50,0,0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: myRecipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: myRecipes[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}