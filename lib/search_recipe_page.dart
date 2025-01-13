import 'package:flutter/material.dart';
import 'models.dart';

class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({super.key});

  @override
  _SearchRecipePageState createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  final _searchController = TextEditingController();
  Future<List<Recipe>>? _searchResults;

  void _searchRecipe() {
    setState(() {
      _searchResults = fetchRecipeListByName(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(labelText: 'Nazwa przepisu'),
          ),
          ElevatedButton(
            onPressed: _searchRecipe,
            child: const Text('Wyszukaj przepis'),
          ),
          FutureBuilder<List<Recipe>>(
            future: _searchResults,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Błąd: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final recipes = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return ListTile(
                        title: Text(recipe.recipeName),
                        subtitle: Text(recipe.recipeIngredients.join(', ')),
                        onTap: () {
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Text('Brak wyników');
              }
            },
          ),
        ],
      ),
    );
  }
}