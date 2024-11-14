import 'package:booking_cook/widgets/full_recipe_card.dart';
import 'package:booking_cook/widgets/new_recipe_page.dart';
import 'package:booking_cook/widgets/recipe_list.dart';
import 'package:booking_cook/widgets/search_page.dart';
import 'package:booking_cook/widgets/top_menu.dart';
import '../model/models.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget _currentContent;

  @override
  void initState() {
    super.initState();
    _currentContent = RecipeList(onRecipeTap: showRecipePage); // callback
  }

  void updateContent(Widget newContent) {
    setState(() {
      _currentContent = newContent;
    });
  }

  void showRecipePage(Recipe recipe) {
    updateContent(RecipeCard(recipe: recipe)); // Przekazanie przepisu do RecipeCard
  }

  void showAddPage() {
    updateContent(NewRecipePage());
  }

  void showMyRecipes() {
    updateContent(RecipeList(onRecipeTap: showRecipePage));
  }

  void showSearchPage() {
    updateContent(SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: _currentContent,
        ),
        TopMenu(
          onAdd: showAddPage,
          onMyRecipes: showMyRecipes,
          onSearch: showSearchPage,
        )
      ],
    );
  }
}
