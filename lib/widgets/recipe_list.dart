import 'package:flutter/cupertino.dart';
import '../model/models.dart';
import './recipe_card.dart';
class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<Recipe> myRecipes = []; // Inicjalizacja listy przepisów

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
    return Expanded(child:
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Liczba kolumn w rzędzie
        crossAxisSpacing: 8, // Odstęp między kolumnami
        mainAxisSpacing: 8,  // Odstęp między rzędami
      ),
      itemCount: myRecipes.length,
      itemBuilder: (context, index){
        return RecipeCard(recipe: myRecipes[index]);
      },
    ));
  }
}