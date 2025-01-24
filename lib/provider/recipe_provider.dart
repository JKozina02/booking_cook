import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/models.dart';
import 'package:http/http.dart' as http;

const String apiKey = 'a417d11919314fcaaba6dea39ece48fd';

class RecipeProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  Future<List<Recipe>>? _searchResults;
  bool _isLoading = false;
  String? _errorMessage;
  List<Recipe> myRecipes = [];

  RecipeProvider() {
    _loadRecipes();
  }

  Future<List<Recipe>>? get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => errorMessage != null;

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

  void showRecipeDetails(BuildContext context, Recipe recipe) {
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
  }

  void addRecipeFromApi(int recipeId) async {
    try {
      final recipe = await fetchRecipeDetails(recipeId);
      final newRecipe = Recipe(
        recipeId: DateTime.now().millisecondsSinceEpoch, // Assign a unique ID based on timestamp
        recipeName: recipe.recipeName,
        recipeIngredients: recipe.recipeIngredients,
        recipeInstruction: recipe.recipeInstruction,
        imagePath: recipe.imagePath,
      );
      myRecipes.add(newRecipe);
      _saveRecipes();
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding recipe from API: $e');
    }
  }

  void addRecipe(String recipeName, List<String> recipeIngredients, String recipeInstruction) {
    final newRecipe = Recipe(
      recipeId: DateTime.now().millisecondsSinceEpoch, // Assign a unique ID based on timestamp
      recipeName: recipeName,
      recipeIngredients: recipeIngredients,
      recipeInstruction: recipeInstruction,
      imagePath: null,
    );
    myRecipes.add(newRecipe);
    _saveRecipes();
    notifyListeners();
  }

  void deleteRecipe(int recipeId) {
    myRecipes.removeWhere((recipe) => recipe.recipeId == recipeId);
    _saveRecipes();
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
      _saveRecipes();
      notifyListeners();
    }
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final recipesJson = myRecipes.map((recipe) => recipe.toJson()).toList();
    prefs.setString('myRecipes', jsonEncode(recipesJson));
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final recipesJson = prefs.getString('myRecipes');
    if (recipesJson != null) {
      final List<dynamic> recipesList = jsonDecode(recipesJson);
      myRecipes = recipesList.map((json) => Recipe.fromJson(json)).toList();
      notifyListeners();
    }
  }
}

Future<List<Recipe>> fetchRecipeListByName(String recipeName) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$recipeName'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['results'] != null && jsonData['results'].isNotEmpty) {
      return (jsonData['results'] as List)
          .map((recipeData) => Recipe.fromSummaryJson(recipeData))
          .toList();
    } else {
      return []; // Return an empty list if no recipes are found
    }
  } else {
    throw Exception('Failed to load recipes: ${response.statusCode}');
  }
}

Future<Recipe> fetchRecipeDetails(int recipeId) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return Recipe.fromJson(jsonData);
  } else {
    throw Exception('Failed to load recipe details: ${response.statusCode}');
  }
}