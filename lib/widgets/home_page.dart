import 'package:booking_cook/widgets/recipe_list.dart';
import 'package:booking_cook/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // displayed site
  Widget _currentContent = RecipeList();
  // change displayed site
  void _updateContent(Widget newContent){
    setState(() {
      _currentContent = newContent;
    });
  }
  void _showAddPage() {
    _updateContent(const Text("Add Page"));
  }

  void _showMyRecipes() {
    _updateContent(RecipeList());
  }

  void _showSearchPage() {
    _updateContent(const Text("Search Page"));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      _currentContent,
      TopMenu(
        onAdd: _showAddPage,
        onMyRecipes: _showMyRecipes,
        onSearch: _showSearchPage,)
    ]);
  }
}
