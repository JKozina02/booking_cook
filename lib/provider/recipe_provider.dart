import 'package:flutter/material.dart';
import '../model/models.dart';

class RecipeProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  Future<List<Recipe>>? _searchResults;
  bool _isLoading = false;
  String? _errorMessage;
  bool get hasError => errorMessage != null;
  List<Recipe> myRecipes = [];
  List<Recipe> likedRecipes = [];

  Future<List<Recipe>>? get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void searchRecipe() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    fetchRecipeListByName(searchController.text).then((results) {
      _searchResults = Future.value(results);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    });
  }

  void showRecipeDetails(BuildContext context, int recipeId, {bool fromSearch = false}) async {
    try {
      final recipe = await fetchRecipeDetails(recipeId);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(recipe.recipeName),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe.imagePath != null)
                    Image.network(recipe.imagePath!),
                  const SizedBox(height: 8),
                  const Text('Składniki:'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recipe.recipeIngredients
                        .map((ingredient) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(ingredient),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  const Text('Instrukcje:'),
                  Text(recipe.recipeInstruction),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            actions: [
              if (fromSearch)
                TextButton(
                  onPressed: () {
                    addRecipe(
                      recipe.recipeName,
                      recipe.recipeIngredients,
                      recipe.recipeInstruction,
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Przepis zapisany!')),
                    );
                  },
                  child: const Text('Zapisz'),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Zamknij'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('Error fetching recipe details: $e');
    }
  }

  void addRecipe(String recipeName, List<String> recipeIngredients, String recipeInstruction) {
    myRecipes.add(Recipe(
      recipeId: myRecipes.length + 1, // Assign a unique ID for the new recipe
      recipeName: recipeName,
      recipeIngredients: recipeIngredients,
      recipeInstruction: recipeInstruction,
      imagePath: null,
    ));
    notifyListeners();
  }

  void deleteRecipe(int recipeId) {
    myRecipes.removeWhere((recipe) => recipe.recipeId == recipeId);
    notifyListeners();
  }

  void editRecipe(int recipeId, String recipeName, List<String> recipeIngredients, String recipeInstruction) {
    final recipeIndex = myRecipes.indexWhere((recipe) => recipe.recipeId == recipeId);
    if (recipeIndex != -1) {
      myRecipes[recipeIndex] = Recipe(
        recipeId: recipeId,
        recipeName: recipeName,
        recipeIngredients: recipeIngredients,
        recipeInstruction: recipeInstruction,
        imagePath: null,
      );
      notifyListeners();
    }
  }
}