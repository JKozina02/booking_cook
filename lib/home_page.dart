import 'package:flutter/material.dart';
import 'add_recipe_page.dart';
import 'search_recipe_page.dart' as search_recipe;
import 'my_recipe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    AddRecipePage(),
    search_recipe.SearchRecipePage(),
    MyRecipePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingCook'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj przepis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Wyszukaj przepis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Przepisy',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}