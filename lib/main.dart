import 'package:flutter/material.dart';
import './model/models.dart';
import './widgets/recipe_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(children: [
              TextButton(
                onPressed: () { addRecipe(
                    'Omlet z warzywami',
                    [
                      '2 jajka',
                      '50g papryki',
                      '50g szpinaku',
                      '50g sera feta',
                      'Sól i pieprz'
                    ],
                    [
                      'Roztrzep jajka w misce z solą i pieprzem.',
                      'Podsmaż paprykę i szpinak na patelni.',
                      'Wlej jajka i posyp fetą.',
                      'Smaż omlet, aż będzie gotowy z obu stron.'
                    ]
                );},
                child: const Text('TextButton'),
                )
              ]
            ),
            RecipeList()
          ]
        )
      ),
    );
  }
}

