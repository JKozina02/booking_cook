import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/recipe_provider.dart';

class MyRecipePage extends StatelessWidget {
  const MyRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Column(
      children: [
        const Text('Moje przepisy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView.builder(
            itemCount: recipeProvider.myRecipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeProvider.myRecipes[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(recipe.recipeName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit functionality
                          showDialog(
                            context: context,
                            builder: (context) {
                              final _recipeNameController = TextEditingController(text: recipe.recipeName);
                              final _ingredientsController = TextEditingController(text: recipe.recipeIngredients.join(', '));
                              final _stepsController = TextEditingController(text: recipe.recipeInstruction);

                              return AlertDialog(
                                title: const Text('Edytuj przepis'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _recipeNameController,
                                        decoration: const InputDecoration(labelText: 'Nazwa przepisu'),
                                      ),
                                      TextField(
                                        controller: _ingredientsController,
                                        decoration: const InputDecoration(labelText: 'Składniki (oddzielone przecinkami)'),
                                      ),
                                      TextField(
                                        controller: _stepsController,
                                        decoration: const InputDecoration(labelText: 'Kroki (oddzielone kropkami)'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      recipeProvider.editRecipe(
                                        recipe.recipeId,
                                        _recipeNameController.text,
                                        _ingredientsController.text.split(', '),
                                        _stepsController.text,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Zapisz'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Anuluj'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          recipeProvider.deleteRecipe(recipe.recipeId);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    recipeProvider.showRecipeDetails(context, recipe.recipeId);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}