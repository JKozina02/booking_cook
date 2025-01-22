import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String apiKey = 'a417d11919314fcaaba6dea39ece48fd';
List<Recipe> myRecipes = [];

class Recipe {
  final int recipeId;
  final String recipeName;
  final List<String> recipeIngredients;
  final String recipeInstruction;
  final String? imagePath;

  Recipe({
    required this.recipeId,
    required this.recipeName,
    required this.recipeIngredients,
    required this.recipeInstruction,
    this.imagePath,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['id'] as int,
      recipeName: json['title'] as String,
      recipeIngredients: (json['extendedIngredients'] as List)
          .map((ingredient) => (ingredient['original'] as String))
          .toList(),
      recipeInstruction: json['instructions'] as String? ?? 'Brak instrukcji',
      imagePath: json['image'] as String?,
    );
  }

  factory Recipe.fromSummaryJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['id'] as int,
      recipeName: json['title'] as String,
      recipeIngredients: [],
      recipeInstruction: '',
      imagePath: json['image'] as String?,
    );
  }
}

Future<List<Recipe>> fetchRecipeListByName(String recipeName) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$recipeName'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    debugPrint(jsonData.toString()); // Print the API response to the console
    if (jsonData['results'] != null && jsonData['results'].isNotEmpty) {
      return (jsonData['results'] as List)
          .map((recipeData) => Recipe.fromSummaryJson(recipeData))
          .toList();
    } else {
      return []; // Return an empty list if no recipes are found
    }
  } else {
    debugPrint('Failed to load recipes: ${response.statusCode}');
    throw Exception('Failed to load recipes: ${response.statusCode}');
  }
}

Future<Recipe> fetchRecipeDetails(int recipeId) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    debugPrint(jsonData.toString()); // Print the API response to the console
    return Recipe.fromJson(jsonData);
  } else {
    debugPrint('Failed to load recipe details: ${response.statusCode}');
    throw Exception('Failed to load recipe details: ${response.statusCode}');
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
}