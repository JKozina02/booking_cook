import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/recipe_provider.dart';
import 'model/models.dart';

class SearchRecipePage extends StatelessWidget {
  const SearchRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: recipeProvider.searchController,
            decoration: const InputDecoration(labelText: 'Nazwa przepisu'),
          ),
          ElevatedButton(
            onPressed: () => recipeProvider.searchRecipe(),
            child: const Text('Wyszukaj przepis'),
          ),
          Consumer<RecipeProvider>(
            builder: (context, provider, child) {
              if (provider.searchResults == null) {
                return const Text('Brak wyników');
              } else if (provider.isLoading) {
                return const CircularProgressIndicator();
              } else if (provider.hasError) {
                return Text('Błąd: ${provider.errorMessage}');
              } else {
                return FutureBuilder<List<Recipe>>(
                  future: provider.searchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Błąd: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Brak wyników');
                    } else {
                      final recipes = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: recipes.length,
                          itemBuilder: (context, index) {
                            final recipe = recipes[index];
                            return ListTile(
                              title: Text(recipe.recipeName),
                              trailing: IconButton(
                                icon: const Icon(Icons.save),
                                onPressed: () {
                                  provider.addRecipeFromApi(recipe.recipeId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Przepis zapisany!')),
                                  );
                                },
                              ),
                              onTap: () {
                                recipeProvider.showRecipeDetails(context, recipe);
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}