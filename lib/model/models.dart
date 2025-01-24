
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

  Map<String, dynamic> toJson() {
    return {
      'id': recipeId,
      'title': recipeName,
      'extendedIngredients': recipeIngredients.map((ingredient) => {'original': ingredient}).toList(),
      'instructions': recipeInstruction,
      'image': imagePath,
    };
  }

  factory Recipe.fromSummaryJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['id'],
      recipeName: json['title'],
      recipeIngredients: [], // Add appropriate parsing if available
      recipeInstruction: '', // Add appropriate parsing if available
      imagePath: json['image'],

    );

  }
}