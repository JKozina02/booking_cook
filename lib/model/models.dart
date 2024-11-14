class Recipe{
  String recipeName;
  List<String> recipeIngredients;
  List<String> recipeSteps;
  String? imagePath;

  Recipe({
    required this.recipeName,
    required this.recipeIngredients,
    required this.recipeSteps,
    this.imagePath
  });
}

List<Recipe> myRecipes= [
  Recipe(
    recipeName: 'Spaghetti Carbonara',
    recipeIngredients: [
      '200g spaghetti',
      '100g pancetta',
      '2 jajka',
      '50g parmezanu',
      'Sól i pieprz'
    ],
    recipeSteps: [
      'Ugotuj spaghetti al dente.',
      'Podsmaż pancettę na patelni.',
      'W misce wymieszaj jajka z parmezanem.',
      'Dodaj spaghetti do pancetty, a następnie dodaj mieszankę jajeczną i dokładnie wymieszaj.'
    ],
  ),
  Recipe(
    recipeName: 'Sałatka Cezar',
    recipeIngredients: [
      'Romaine sałata',
      'Grzanki',
      '50g parmezanu',
      'Sos Cezar',
      'Pierś z kurczaka'
    ],
    recipeSteps: [
      'Podsmaż kurczaka i pokrój na kawałki.',
      'Posiekaj sałatę i przełóż do miski.',
      'Dodaj grzanki, parmezan i kurczaka.',
      'Polej sosem Cezar i dokładnie wymieszaj.'
    ],
  ),
  Recipe(
    recipeName: 'Zupa Pomidorowa',
    recipeIngredients: [
      '500g pomidorów',
      '1 cebula',
      '2 ząbki czosnku',
      'Bulion warzywny',
      'Śmietana do dekoracji'
    ],
    recipeSteps: [
      'Podsmaż cebulę i czosnek.',
      'Dodaj pokrojone pomidory i bulion, gotuj przez 20 minut.',
      'Zblenduj zupę na gładką konsystencję.',
      'Podaj ze śmietaną na wierzchu.'
    ],
  ),
];


void addRecipe(String recipeName, List<String> recipeIngredients, List<String> recipeSteps){
  myRecipes.add(Recipe(recipeName: recipeName, recipeIngredients: recipeIngredients, recipeSteps: recipeSteps));
}

