import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  final VoidCallback onAdd;
  final VoidCallback onMyRecipes;
  final VoidCallback onSearch;

  const TopMenu({
    super.key,
    required this.onAdd,
    required this.onMyRecipes,
    required this.onSearch,
  });

  @override
  State<TopMenu> createState() => _TopMenuState();
}

  class _TopMenuState extends State<TopMenu>{
    bool isOpen = false;

    void _toggleMenu() {
      setState(() {
        isOpen = !isOpen;
      });
    }
    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          _toggleMenu();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isOpen ? 200 : 50,
          color: const Color(0xFFD8D8D8),  // Kolor tła
          child: Center(
            child: isOpen
                ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(onPressed: (){widget.onAdd(); _toggleMenu();}, child: const Text("Add")),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(onPressed: (){widget.onMyRecipes(); _toggleMenu();}, child: const Text("My Recepes")),
                    ElevatedButton(onPressed: (){widget.onSearch(); _toggleMenu();}, child: const Text("Search"))
                  ]),
                ])
                : const Text('Menu is Closed', style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }
}