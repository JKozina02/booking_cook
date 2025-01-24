import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/recipe_provider.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _recipeNameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  void _addRecipe() {
    if (_formKey.currentState!.validate()) {
      Provider.of<RecipeProvider>(context, listen: false).addRecipe(
        _recipeNameController.text,
        _ingredientsController.text.split(','),
        _stepsController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Przepis dodany!')),
      );
      _recipeNameController.clear();
      _ingredientsController.clear();
      _stepsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _recipeNameController,
              decoration: const InputDecoration(labelText: 'Nazwa przepisu'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę podać nazwę przepisu';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: const InputDecoration(labelText: 'Składniki (oddzielone przecinkami)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę podać składniki';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stepsController,
              decoration: const InputDecoration(labelText: 'Kroki (oddzielone kropkami)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Proszę podać kroki';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _addRecipe,
              child: const Text('Dodaj przepis'),
            ),
          ],
        ),
      ),
    );
  }
}