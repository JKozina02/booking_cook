import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'a417d11919314fcaaba6dea39ece48fd';

List<Recipe> recipeList = [];

Future<Recipe> fetchRecipeById(int recipeId) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'));

  if (response.statusCode == 200) {
    final recipeData = jsonDecode(response.body);
    return Recipe.fromJson(recipeData);
  } else {
    throw Exception('Failed to load recipe: ${response.statusCode}');
  }
}

Future<List<Recipe>> fetchRecipeListByName(String recipeName) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$recipeName'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    if (jsonData['results'] != null && jsonData['results'].isNotEmpty) {
      return (jsonData['results'] as List)
          .map((recipeData) => Recipe.fromJson(recipeData))
          .toList();
    } else {
      return []; // Return an empty list if no recipes are found
    }
  } else {
    throw Exception('Failed to load recipes: ${response.statusCode}');
  }
}
class Recipe {
  String recipeName;
  List<String> recipeIngredients;
  String recipeInstruction;
  String? imagePath;

  Recipe({
    required this.recipeName,
    required this.recipeIngredients,
    required this.recipeInstruction,
    this.imagePath,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeName: json['title'] as String,
      recipeIngredients: (json['extendedIngredients'] as List)
          .map((ingredient) => (ingredient['original'] as String))
          .toList(),
      recipeInstruction: json['instructions'] as String,
      imagePath: json['image'] as String?,
    );
  }
}