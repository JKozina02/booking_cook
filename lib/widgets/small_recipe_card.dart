import 'package:booking_cook/model/models.dart';
import 'package:flutter/material.dart';

class SmallRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const SmallRecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap, // Wywołanie onTap przy dotknięciu
        child: SizedBox(
          width: 250,
          height: 350,
          child: Card(
            child: Column(
              children: [
                Text(recipe.recipeName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}